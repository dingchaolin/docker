# docker 

## 1. image

### 1.1 获取镜像
- docker pull
- docker pull alpine:3.2 从官方获取ubuntu仓库标记为12.04的镜像
- docker pull registry.hub.docker.com/alpine:3.2 从第三方registry.hub.docker.com获取ubuntu仓库标记为12.04的镜像
- 运行docker run -t -i alpine:3.2 /bin/bash启动镜像

### 1.2 列出镜像
- docker images，其中ID相同则表示同意镜像

### 1.3 创建镜像

#### 1.3.1 修改已有镜像
- 使用run启动镜像
- 修改内部内容
- exit退出
- docker commit -m "备注" -a "18810042351@163.com" jasperxu/alpine:v2
- 运行 docker run -t -i jasperxu/alpine:v2 /bin/bash 启动镜像

#### 1.3.2 使用Dockfile创建镜像
- 创建Dockfile文件
```
# This is a commit
FROM alpine:3.2
MAINTAINER Jasper Xu <sorex@163.com>

RUN apk update &&      apk add socat &&        rm -r /var/cache/
```

#### 1.3.2 使用build来创建镜像
- docker build -t jasperxu/alpine:v3 .
- -t 仓库名称 jasperxu/alpine,jasperxu/alpine:v3,支持多个docker build -t jasperxu/alpine:v3 -t jasperxu/aaa .
- . Dockerfile文件所在路径(当前目录)，如果在上一级目录可使用./alpine

#### 1.3.3 使用新建的镜像来创建容器
- docker run -t -i jasperxu/alpine:v3 /bin/bash

### 1.4 移除镜像
- docker rmi xxxxxxxxxxxx
- docker rmi jasperxu/alpine
- docker rmi jasperxu/alpine:v3
- 移除镜像前需要移除依赖于该镜像的所有容器使用docker rm

### 1.5 导入和导出

#### 1.5.1 保存镜像到本地
- docker save jasperxu/alpine:v3 > alpine.tar

#### 1.5.2 导入本地文件到镜像
- docker load < alpine.tar 

### 1.6 其他

#### 1.6.1 修改镜像标签
-  docker tag xxxxxxxxxxxx jasperxu/alpine:devel

#### 1.6.2 上传镜像
- docker push jasperxu/alpine

## 2. Dockerfile 详解

### 2.1 基本示例
```
# This is a commit
FROM alpine:3.2
MAINTAINER Jasper Xu <sorex@163.com>

RUN apk update &&      apk add socat &&        rm -r /var/cache/
RUN chmod -R 755 /data

ADD execfile /etc/execfile
ADD data/* /etc/data/
COPY xxx.tgz /home/xxx.tgz

RUN chmod 755 /etc/execfile
RUN ["/etc/execfile", "arg1", "arg1"]

ENV abc=hello

VOLUME ["/data"]

EXPOSE 8080

WORKDIR /data/tools

CMD service nginx start
CMD echo "Hello docker!"
```

### 2.2 FROM 
- 必须是第一个命令， 指定基础镜像
```
FROM <image>
FROM <image>:<tag>
FROM <image>@<digest>
```
- FROM mysql:5.6

### 2.3 MAINTAINER
- 维护者信息
- MAINTAINER <name>
```
MAINTAINER Jasper Xu
MAINTAINER sorex@163.com
MAINTAINER Jasper Xu <sorex@163.com>
```
### 2.4 LABEL 
- 给镜像添加信息。使用docker inspect可查看镜像的相关信息
```
LABEL "com.example.vendor"="ACME Incorporated"
LABEL com.example.label-with-value="foo"
LABEL version="1.0"
LABEL description="This text illustrates \
that label-values can span multiple lines."
```

### 2.5 RUN
- 构建镜像时执行的命令
```
# 由shell启动，Linux默认为`/bin/sh -c`，Windows默认为`cmd /S /C`
RUN <command>
# 运行可执行文件
RUN ["executable", "param1", "param2"]
```
```
RUN apk update
RUN ["/etc/execfile", "arg1", "arg1"]
```

### 2.6 ADD
- 将本地文件添加到容器中，identity, gzip, bzip2，xz，tar.gz，tgz等类型的文件将被添加tar -x命令，进行解压
```
ADD <src>... <dest>
ADD ["<src>",... "<dest>"] 用于支持包含空格的路径
```

```
ADD hom* /mydir/        # 添加所有以"hom"开头的文件
ADD hom?.txt /mydir/    # ? 替代一个单字符,例如："home.txt"

ADD test relativeDir/          # 添加 "test" 到 `WORKDIR`/relativeDir/
ADD test /absoluteDir/         # 添加 "test" 到 /absoluteDir/

```

### 2.7 COPY
- 同ADD，只是不会解压文件。

### 2.8 CMD
- 构建容器后调用，也就是在容器启动时才进行调用。
```
CMD ["executable","param1","param2"] (执行可执行文件，优先)
CMD ["param1","param2"] (设置了ENTRYPOINT，则直接调用ENTRYPOINT添加参数)
CMD command param1 param2 (执行shell内部命令)
```

```
CMD echo "This is a test." | wc -
CMD ["/usr/bin/wc","--help"]
```

### 2.9 ENTRYPOINT
- 配置容器，使其可执行化。配合CMD可省去"application"，只使用参数。
```
ENTRYPOINT ["executable", "param1", "param2"] (可执行文件, 优先)
ENTRYPOINT command param1 param2 (shell内部命令)
```
```
ENTRYPOINT ["executable", "param1", "param2"] (可执行文件, 优先)
ENTRYPOINT command param1 param2 (shell内部命令)
```
- 当启动容器后，你将直接看到相当于运行了top -b -c
- 要进一步查看，你可以直接使用命令docker exec -it test ps aux
- 相当于使用了docker exec top -b -it test ps aux

### 2.10 ENV
- 设置环境变量
```
ENV <key> <value>
ENV <key>=<value> ...
```

```
ENV myName="John Doe" myDog=Rex\ The\ Dog \
    myCat=fluffy
```
- 等同于
```
ENV myName John Doe
ENV myDog Rex The Dog
ENV myCat fluffy
```

### 2.11 EXPOSE
- 指定于外界交互的端口，在容器启动时用-p传递参数，例如-p 3307:3306将容器内的3306绑定到本机的3307
- EXPOSE <port> [<port>...]
```
EXPOSE 80 443
EXPOSE 8080
```

### 2.12 VOLUME
- 用于指定持久化目录，在容器启动时用-v传递参数
- 例如-v ~/opt/data/mysql:/var/lib/mysql将本机的~/opt/data/mysql和容器内的/var/lib/mysql做持久化关联
- 容器启动时会加载，容器关闭后会回写。
- VOLUME ["/data"]
```
VOLUME ["/data"]
VOLUME ["/var/www", "/var/log/apache2", "/etc/apache2"]
```

### 2.13 WORKDIR
- 工作目录
- WORKDIR /path/to/workdir
```
WORKDIR /a  (这时工作目录为/a)
WORKDIR b  (这时工作目录为/a/b)
WORKDIR c  (这时工作目录为/a/b/c)
```

### 2.14 USER
- 用于设定容器的运行用户名或UID,USER 123或USER git。
- RUN, CMD and ENTRYPOINT都将用该用户执行。

### 2.15 ARG
- 由外部启动时必须传入的参数，在容器启动时用--build-arg传递参数
- 指定于外界交互的端口，在容器启动时用-p传递参数，例如--build-arg CONT_IMG_VER=v2.0.1
```
FROM ubuntu
2 ARG CONT_IMG_VER
3 ENV CONT_IMG_VER ${CONT_IMG_VER:-v1.0.0}
4 RUN echo $CONT_IMG_VER
```
- 有些默认参数，无需指定，也不用使用``传递，可直接传参
- HTTP_PROXY,http_proxy,HTTPS_PROXY,https_proxy,FTP_PROXY,ftp_proxy,NO_PROXY,no_proxy

## 3. Container

### 3.1 启动容器

#### 3.1.1 新建并启动
- docker run alpine:3.2 /bin/echo 'Hello, World'
- 和本地执行/bin/echo 'Hello, World'基本无差别。
- 启动bash，docker run -t -i alpine:3.2 /bin/sh
- -t 让Docker分配一个伪终端(pseudo-TTY)
- -i 让容器的标准输入(stdin)保持打开
- -d 后台运行

#### 3.1.2 启动已终止容器
- docker start [container ID or NAMES]

#### 3.1.3 启动并进入
-  docker start -i [container ID or NAMES]

### 3.2  后台运行
- 添加-d参数，输出内容将不输出到标准输出(stdout)。
- 要查看输出需要使用docker logs [container ID or NAMES]
- 使用-d启动后会返回一个唯一id。
- docker ps -a可以查看容器信息

### 3.3 终止
- docker stop [container ID or NAMES]
- docker restart [container ID or NAMES]

### 3.4 导入和导出

#### 3.4.1 导出
- docker export 7691a814370e > alpine.tar

#### 3.4.2 导入
```
# 远程导入
docker import http://example.com/exampleimage.tgz
# 本地导入
cat exampleimage.tgz | docker import - exampleimagelocal:new
# 导入并提交信息
cat exampleimage.tgz | docker import --message "New image imported from tarball" - exampleimagelocal:new
# 导入并存档
docker import /path/to/exampleimage.tgz
# 从目录导入
sudo tar -c . | docker import - exampleimagedir
# 用新的配置导入
sudo tar -c . | docker import --change "ENV DEBUG true" - exampleimagedir
```

### 3.5 删除
- docker rm [container ID or NAMES]
- 清理所有处于终止状态的容器
- docker rm $(docker ps -a -q)