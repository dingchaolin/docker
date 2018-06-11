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

https://hub.docker.com/_/node/
https://hub.daocloud.io/repos/6564230d-84b5-4789-90f9-98c298ab071b




