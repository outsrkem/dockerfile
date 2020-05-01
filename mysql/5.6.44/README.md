### docker 镜像构建命令

```
docker build -t mysqld:5.6.44 .
```

### 启动容器

```
docker run -d --name db-mysql -p 3306:3306 --env MYSQL_ROOT_PASSWORD=123456 mysqld:5.6.44
```

### 停止容器

```
docker kill db-mysql
```