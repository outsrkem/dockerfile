### docker 镜像构建命令

```
docker build -t nginx:1.17.5 .
```

### 启动容器

```
docker run -d --name nginx -v 80:80 nginx:1.17.5 
```