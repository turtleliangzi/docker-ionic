# 用dockerfile搭建基于ubuntu的lnmp及laravel开发环境镜像

## 一、下载
```
git clone https://github.com/turtleliangzi/docker-laravel.git
```

## 二、build

```
docker build -t 镜像名:版本号 .

```

## 三、运行

```
docker run -id -p 80:80 -v /var/www/html:/var/www/html 镜像名:版本号

```

* 其中数据库root密码为空

* -p 80:80 第一个80为宿主机上的80端口，第二个80为docker上的80端口

* -v /var/www/html:/var/www/html 第一个/var/www/html为宿主机上的web路径，第二个为docker的web路径


## 四、添加文件

在本地/var/www/html目录中添加html或php文件，然后访问localhost/文件名即可

