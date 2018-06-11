FROM daocloud.io/node:8.4.0-onbuild
MAINTAINER 18810042351@163.com

ENV HTTP_PORT 8000

COPY . /app
WORKDIR /app

RUN npm --registry=https://registry.npm.taobao.org --disturl=https://npm.taobao.org/dist install

EXPOSE 8000

CMD ["npm", "start"]
