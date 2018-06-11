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



## 3. Dockfile 参数

### 3.1 FROM 

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
- 列表 最新 8.4.0-onbuild
- 地址 daocloud.io/library/node
- 拉取镜像 docker pull daocloud.io/library/node:8.4.0-onbuild




