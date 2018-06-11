# docker

## 安装

#### 1. centos内核版本要求高于3.10
- uname -r  查看内核版本

#### 2. 更新yum
- sudo yum update

#### 3. 卸载旧版本（如果安装过）
- sudo yum remove docker  docker-common docker-selinux docker-engine


#### 4. 安装需要的软件包， yum-util 提供yum-config-manager功能，另外两个是devicemapper驱动依赖的
- sudo yum install -y yum-utils device-mapper-persistent-data lvm2

#### 5. 安装docker
- yum -y install docker-io

#### 6. 启动docker后台服务
- service docker start




