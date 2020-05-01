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