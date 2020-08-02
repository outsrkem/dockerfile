### 镜像构建命令

```
docker build -t nginx:1.15.2 . -t Dockerfile
```

### 拉取我的镜像

```
docker pull registry.cn-shanghai.aliyuncs.com/outsrkem/nginx:1.15.2
```

### 启动容器

```
docker run -d --name nginx -p 80:80 nginx:1.15.2
```

### 停止容器

```
docker kill nginx
```

###  查看容器重启策略

```
docker inspect -f "{{ .HostConfig.RestartPolicy.Name }}" nginx
```

###  修改容器重启策略

```
docker update --restart=always nginx
```
