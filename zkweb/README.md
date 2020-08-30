### 镜像构建命令

```
docker build -t zkweb:1.2.1 . -f Dockerfile
```

### 启动容器

```
docker run -d --name zkweb -p 80:8099 zkweb:1.2.1
```

### 停止容器

```
docker kill zkweb
```

###  查看容器重启策略

```
docker inspect -f "{{ .HostConfig.RestartPolicy.Name }}" zkweb
```

###  修改容器重启策略

```
docker update --restart=always zkweb
```


