### git 常用操作

```
git add -A
```

##### 添加描述
```
DA=`date`
git commit -m "$DA"
```

##### 推送到仓库
```
git push origin master
```

##### ~~~
```
DA=`date`
git add -A &&  git commit -m "$DA 更新文件" && git push origin master
```

#### docker 安装

```
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.163.com/.help/CentOS7-Base-163.repo
curl -o /etc/yum.repos.d/docker-ce.repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
yum clean all && yum makecache
yum install docker-ce-18.09.8 git -y
mkdir /etc/docker
cat > /etc/docker/daemon.json << EOF
{
  "registry-mirrors": ["https://kz7brmw7.mirror.aliyuncs.com"]
}
EOF
```