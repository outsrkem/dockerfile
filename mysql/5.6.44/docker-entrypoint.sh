#!/bin/bash
set -e

# if command starts with an option, prepend mysqld
# 用于判断该脚本后面的参数是否以“-”开始，它考虑的是启动mysqld是带参数的情况，如果有的话，就将mysqld和参数作为变量存到$@中。
if [ "${1:0:1}" = '-' ]; then
	# $@代表命令行中所有的参数，但把每个参数区分对待
	set -- mysqld "$@"
fi

# $1 为mysqld，CMD中的参数
if [ "$1" = 'mysqld' ]; then
	# Get config
	# 获取mysql server的数据目录,倘若我们没有输入任何以“-”开始的参数列表，则$@为mysqld，上述命令执行的结果如下：
	# mysqld --verbose --help 2>/dev/null | awk '$1 == "datadir" { print $2; exit }'
	# /var/lib/mysql/
	# 此处需要优化
	#DATADIR="$("$@" --verbose --help 2>/dev/null | awk '$1 == "datadir" { print $2; exit }')"
	DATADIR='/usr/local/mysql/data'
	echo $@
	echo $DATADIR
	echo $PATH
	# 如果存在/var/lib/mysql/mysql 目录，则跳过中间的步骤，直接执行chown -R mysql:mysql "$DATADIR"，
	# 它这里判断的一个依据是，如果/var/lib/mysql/mysql存在文件，则代表mysql server已经安装，这时就无需安装
	if [ ! -d "$DATADIR/mysql" ]; then
		# -z 判断空为真 -a 都成立为真
		if [ -z "$MYSQL_ROOT_PASSWORD" -a -z "$MYSQL_ALLOW_EMPTY_PASSWORD" ]; then
			echo >&2 'error: 数据库未初始化，MYSQL_ROOT_PASSWORD未设置'
			echo >&2 '  您是否忘记添加-e MYSQL_ROOT_PASSWORD=... ?'
			exit 1
		fi

		mkdir -p "$DATADIR"
		chown -R mysql:mysql "$DATADIR"

		echo 'Running mysql_install_db'
        
        # 切换脚本工作目录，初始化，启动都需要在mysql目录中。
		cd /usr/local/mysql
		./scripts/mysql_install_db --user=mysql --datadir="$DATADIR" 

		echo 'Finished mysql_install_db'

		mysqld --user=mysql --datadir="$DATADIR" &
		# Shell最后运行的后台Process的PID,即上面命令的pid
		pid="$!"

		# 这里面利用括号()构造mysql变量,验证如下
		mysql=( mysql --protocol=socket -uroot )
		# [root@localhost-21 bin]# mysql=( mysql --protocol=socket -uroot )
		# [root@localhost-21 bin]# echo ${mysql[@]}
		# mysql --protocol=socket -uroot


		# 这段代码给了30s的时间来判断mysql服务是否已启动，如果启动了，则退出循环，
		# 如果没有启动，循环结束后，变量i的值为0，通过后续的if语句，屏幕输出“MySQL init process failed”。
		for i in {30..0}; do
			# 如果数据库启动，此时if 条件为真，跳出退出循环
			if echo 'SELECT 1' | "${mysql[@]}" &> /dev/null; then
				break
			fi
			echo 'MySQL 进程正在进行中...'
			sleep 1
		done
		if [ "$i" = 0 ]; then
			echo >&2 'MySQL 进程初始化失败.'
			exit 1
		fi

		# sed is for https://bugs.mysql.com/bug.php?id=20545
		mysql_tzinfo_to_sql /usr/share/zoneinfo | sed 's/Local time zone must be set--see zic manual page/FCTY/' | "${mysql[@]}" mysql

		# 下面这一段执行SQL语句。
		# "${mysql[@]}" 该语句能够登陆数据库，此处按需优化。
 		"${mysql[@]}" <<EOSQL
			-- What's done in this file shouldn't be replicated
			--  or products like mysql-fabric won't work
			SET @@SESSION.SQL_LOG_BIN=0;
			DELETE FROM mysql.user ;
			CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' ;
			GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION ;
			DROP DATABASE IF EXISTS test ;
			FLUSH PRIVILEGES ;
EOSQL

		# -z 判断空为真，[ ! -z "$MYSQL_ROOT_PASSWORD" ] 判断变量有值为真
		if [ ! -z "$MYSQL_ROOT_PASSWORD" ]; then
			mysql+=( -p"${MYSQL_ROOT_PASSWORD}" )
		fi

		# MYSQL_DATABASE 变量有值时条件成立。
		if [ "$MYSQL_DATABASE" ]; then
			echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` ;" | "${mysql[@]}"
			mysql+=( "$MYSQL_DATABASE" )
		fi

		# MYSQL_USER和MYSQL_PASSWORD 都有值时条件成立，执行创建用户的SQL语句。
		if [ "$MYSQL_USER" -a "$MYSQL_PASSWORD" ]; then
			echo "CREATE USER '"$MYSQL_USER"'@'%' IDENTIFIED BY '"$MYSQL_PASSWORD"' ;" | "${mysql[@]}"

			# 当MYSQL_DATABASE 需要创建时(变量有值)，授予用户$MYSQL_USER对$MYSQL_DATABASE"的权限。 如下面的语句。
			# GRANT ALL ON `my_DB`.* TO 'lis'@'%' ;
			if [ "$MYSQL_DATABASE" ]; then
				echo "GRANT ALL ON \`"$MYSQL_DATABASE"\`.* TO '"$MYSQL_USER"'@'%' ;" | "${mysql[@]}"
			fi
			# 刷新权限。
			echo 'FLUSH PRIVILEGES ;' | "${mysql[@]}"
		fi

		echo
		for f in /docker-entrypoint-initdb.d/*; do
			case "$f" in
				# 执行 .sh 结尾的脚本
				*.sh)  echo "$0: running $f"; . "$f" ;;
				# 执行 .sql 结尾的脚本
				*.sql) echo "$0: running $f"; "${mysql[@]}" < "$f" && echo ;;
				# 忽略其余的文件
				*)     echo "$0: ignoring $f" ;;
			esac
			echo
		done

		if ! kill -s TERM "$pid" || ! wait "$pid"; then
			echo >&2 'MySQL 进程初始化失败.'
			exit 1
		fi

		echo
		echo 'MySQL 完成init进程, 准备启动.'
		echo
	fi

	chown -R mysql:mysql "$DATADIR"
fi

# 如果启动时不加自定义命令，则在上面已经启动mysql
exec "$@"