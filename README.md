# docker

## 1. 安装

#### 1.1 centos内核版本要求高于3.10
- uname -r  查看内核版本

#### 1.2 更新yum
- sudo yum update

#### 1.3 卸载旧版本（如果安装过）
- sudo yum remove docker  docker-common docker-selinux docker-engine


#### 1.4 安装需要的软件包， yum-util 提供yum-config-manager功能，另外两个是devicemapper驱动依赖的
- sudo yum install -y yum-utils device-mapper-persistent-data lvm2

#### 1.5 安装docker
- yum -y install docker-io

#### 1.6 启动docker后台服务
- service docker start


## 2. 一个简单的docker+nodejs实践

#### 2.1 简单的服务

- index.js
```
const express = require('express');

const app = express();

const server = require('http').createServer(app);

app.get('/', function (req, res) {
    res.end("hello, docker + nodejs");
});

app.get('/welcome', function (req, res) {
    res.end("hello, world!");
});

let port = process.env.HTTP_PORT || 9000;

server.listen(port);

console.log('Listening on port %s', port);
```

- .dockerignore
```
     node_modules/
     .git
     .gitignore
     .idea
     .DS_Store
     *.swp
     *.log
```

- .gitignore
- package.json
- Dockerfile
```
# docker_nodejs
#
# VERSION               1.0.0

FROM daocloud.io/node:5

ENV HTTP_PORT 9000

COPY . /app
WORKDIR /app

RUN npm --registry=https://registry.npm.taobao.org --disturl=https://npm.taobao.org/mirrors/node install

EXPOSE 9000

CMD ["npm", "start"]
```


## 3. Dockfile 参数

### 3.1 FROM 
- 基础镜像
- FROM  image : tag  
- FROM  image  
- daocloud.io/node:5 和 node:5 其实是同一个image，出于速度考虑选择 daocloud.io/node:5

#### 3.1.1 原生 https://hub.docker.com/_/node/
- node镜像列表: https://hub.docker.com/_/node/  需要翻墙
- 写法  FROM node:9.11.1-jessie
- 列表:
```
Supported tags and respective Dockerfile links
9.11.1-jessie, 9.11-jessie, 9-jessie, 9.11.1, 9.11, 9 (9/jessie/Dockerfile)
9.11.1-alpine, 9.11-alpine, 9-alpine (9/alpine/Dockerfile)
9.11.1-onbuild, 9.11-onbuild, 9-onbuild (9/onbuild/Dockerfile)
9.11.1-slim, 9.11-slim, 9-slim (9/slim/Dockerfile)
9.11.1-stretch, 9.11-stretch, 9-stretch (9/stretch/Dockerfile)
8.11.2-jessie, 8.11-jessie, 8-jessie, carbon-jessie, 8.11.2, 8.11, 8, carbon (8/jessie/Dockerfile)
8.11.2-alpine, 8.11-alpine, 8-alpine, carbon-alpine (8/alpine/Dockerfile)
8.11.2-onbuild, 8.11-onbuild, 8-onbuild, carbon-onbuild (8/onbuild/Dockerfile)
8.11.2-slim, 8.11-slim, 8-slim, carbon-slim (8/slim/Dockerfile)
8.11.2-stretch, 8.11-stretch, 8-stretch, carbon-stretch (8/stretch/Dockerfile)
6.14.2-jessie, 6.14-jessie, 6-jessie, boron-jessie, 6.14.2, 6.14, 6, boron (6/jessie/Dockerfile)
6.14.2-alpine, 6.14-alpine, 6-alpine, boron-alpine (6/alpine/Dockerfile)
6.14.2-onbuild, 6.14-onbuild, 6-onbuild, boron-onbuild (6/onbuild/Dockerfile)
6.14.2-slim, 6.14-slim, 6-slim, boron-slim (6/slim/Dockerfile)
6.14.2-stretch, 6.14-stretch, 6-stretch, boron-stretch (6/stretch/Dockerfile)
10.4.0-jessie, 10.4-jessie, 10-jessie, jessie, 10.4.0, 10.4, 10, latest (10/jessie/Dockerfile)
10.4.0-alpine, 10.4-alpine, 10-alpine, alpine (10/alpine/Dockerfile)
10.4.0-slim, 10.4-slim, 10-slim, slim (10/slim/Dockerfile)
10.4.0-stretch, 10.4-stretch, 10-stretch, stretch (10/stretch/Dockerfile)
chakracore-8.11.1, chakracore-8.11, chakracore-8 (chakracore/8/Dockerfile)
chakracore-10.1.0, chakracore-10.1, chakracore-10, chakracore (chakracore/10/Dockerfile)
```
#### 3.1.2 国内代理 https://hub.daocloud.io/repos/6564230d-84b5-4789-90f9-98c298ab071b
- https://hub.daocloud.io/repos/6564230d-84b5-4789-90f9-98c298ab071b  不用翻墙
- 写法 FROM daocloud.io/node:8.4.0-onbuild    
- 列表 最新 8.4.0-onbuild   8.7-alpine
- 地址 daocloud.io/library/node
- 拉取镜像 docker pull daocloud.io/library/node:8.4.0-onbuild
- **使用 8.4.0-onbuild   8.7-alpine 生成镜像一直无法成功  使用node:5能正常生成**

#### 3.1.3 http://docker.mirrors.ustc.edu.cn

### 3.2 ENV
- ENV 指令用来设定一个环境变量，会被后续 RUN 指令使用，并在容器运行时保持。
- 格式： ENV KEY value  
- 可以看到之前js文件有用到 process.env.HTTP_PORT，就是在这里设定的。

### 3.3 COPY
- 拷贝项目文件
- COPY 指令用来复制本地主机的文件到容器中
- 格式: COPY src dest 
- COPY . /app
```
这里把我们项目目录本身，即当前目录 . 拷贝至容器的 /app 位置。然后通过指令 WORKDIR 将 /app 目录设为工作目录。工作目录可以理解为运行时的 pwd。

``` 

### 3.4 WORKDIR 
- 设置工作目录。工作目录可以理解为运行时的 pwd。

### 3.5 RUN
- 然后在 /app 目录中执行我们特别熟悉的 npm install，这里我们要用 RUN 指令来执行。

### 3.6 EXPOSE
- 指定容器监听的端口
- 作为一个服务，来让外部通过端口来访问，通过 EXPOSE 指令来指定端口号，很像我们的 module.exports
- 此处端口应该和我们服务监听的端口保持一致


### 3.7 CMD
- 当这个容器运行的时候，如何启动这个服务。我们 npm start 就可以了，因为我们在 package.json 中设置了 scripts.start。

## 4. 生成镜像
- git clone https://github.com/dingchaolin/docker-nodejs.git  test
- cd test
- docker build -t testimg .
- 会生成一个名字为 testimg 的镜像

## 5. 启动镜像
- docker run -name testcontainer -p 9999:9000 testimg
- 启动之后就能在可以访问该服务了  192.168.XXX.XXX:9999/

## 6. docker 命令相关
- docker images  查看本地所有的镜像
- docker ps  查看本地所有docker启动的镜像服务
- docker rmi testimg  删除镜像  
- docker rmi --force testimg 强制删除
- docker run --name testcontainer [-d] -p 9999:9000 testimg 
- docker run --name testcontainer  -p 8080:8080 -p 80:80  test02
```
创建的容器名称是 testcontainer，可以理解为 pid，这个名称唯一，创建之后如果不删除会一直存在。
-p 用来指定端口映射，将容器的端口9000映射到主机9999端口上，这样就可外部访问了。
每一个-p可以映射一个端口
-d 后台启动
```
- 停止容器 docker stop testcontainer  
- 重启容器 docker restart testcontainer  
- 删除容器 docker rm testcontainer  

### run 的可选项
```
-a stdin: 指定标准输入输出内容类型，可选 STDIN/STDOUT/STDERR 三项；
-d: 后台运行容器，并返回容器ID；
-i: 以交互模式运行容器，通常与 -t 同时使用；
-t: 为容器重新分配一个伪输入终端，通常与 -i 同时使用；
--name="nginx-lb": 为容器指定一个名称；
--dns 8.8.8.8: 指定容器使用的DNS服务器，默认和宿主一致；
--dns-search example.com: 指定容器DNS搜索域名，默认和宿主一致；
-h "mars": 指定容器的hostname；
-e username="ritchie": 设置环境变量；
--env-file=[]: 从指定文件读入环境变量；
--cpuset="0-2" or --cpuset="0,1,2": 绑定容器到指定CPU运行；
-m :设置容器使用内存最大值；
--net="bridge": 指定容器的网络连接类型，支持 bridge/host/none/container: 四种类型；
--link=[]: 添加链接到另一个容器；
--expose=[]: 开放一个端口或一组端口；
```

## 7. 关于多个容器映射到同一端口(未找到比较好的办法)
- 方式1 : 未验证
```
The best, easiest option, is to configure the host operating system with "IP Aliasing", what means adding multiple IP addresses to a single network interface.

Then you configure each Docker container attaching to a different IP address of the host OS. That way they all Docker containers can run on the same port.
```
- 方式2 : nginx



