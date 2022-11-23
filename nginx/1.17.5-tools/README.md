### docker 镜像构建命令

```
docker build -t nginx:1.17.5-tools .
```

### 启动容器

```
docker run -d --name nginx -p 80:80 443:443 nginx:1.17.5-tools
```

### 停止容器

```
docker kill nginx
```