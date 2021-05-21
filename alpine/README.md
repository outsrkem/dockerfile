docker golang alpine中遇到 sh xxx not found
https://my.oschina.net/u/727875/blog/4556125
https://blog.csdn.net/u011124985/article/details/80774171
https://blog.csdn.net/j3T9Z7H/article/details/106232650
docker golang alpine中遇到 sh: xxx: not found
原因
由于alpine镜像使用的是musl libc而不是gnu libc，/lib64/ 是不存在的。但他们是兼容的，可以创建个软连接过去试试

处理，创建lib64的软连接

```
mkdir /lib64
ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2
```