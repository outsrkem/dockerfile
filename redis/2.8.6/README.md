### 使用我封装好的

```
docker pull registry.cn-shanghai.aliyuncs.com/outsrkem/redis:2.8.6
```

### 启动容器

```
docker run -d --name redis -p6379:6379 registry.cn-shanghai.aliyuncs.com/outsrkem/redis:2.8.6
```

### 查看容器重启策略

```
docker inspect -f "{{ .HostConfig.RestartPolicy.Name }}" redis
```

### 修改容器重启策略

```
docker update --restart=always redis
```
