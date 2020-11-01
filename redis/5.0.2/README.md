### 构建镜像
```
docker build -t redis:1.15.2 .
```

### 拉取我的镜像

```
docker pull registry.cn-shanghai.aliyuncs.com/outsrkem/redis:5.0.2
docker pull registry.cn-shanghai.aliyuncs.com/outsrkem/redis:5.0.2-tools
```

### 启动容器

```shell
docker run -d --name redis -p 6379:6379 registry.cn-shanghai.aliyuncs.com/outsrkem/redis:5.0.2

# REDIS_CONF 指定配置文件路径，启动时使用的是默认配置文件
# REDIS_DB_PORT 指定服务端口
```

### 停止容器

```
docker kill redis
```

### 其他

```shell
/usr/local/redis
├── bin
|   ├── redis-benchmark
|   ├── redis-check-aof
|   ├── redis-check-rdb
|   ├── redis-cli
|   ├── redis-sentinel -> redis-server
|   └── redis-server
├── conf
|   └── redis.conf
├── data
├── log
└── run
```


