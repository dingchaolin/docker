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
  