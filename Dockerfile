# docker_nodejs
#
# VERSION               1.0.0

FROM daocloud.io/node:8.4.0-onbuild

ENV HTTP_PORT 9000

COPY . /app
WORKDIR /app

RUN npm --registry=https://registry.npm.taobao.org --disturl=https://npm.taobao.org/dist install

EXPOSE 9000

CMD ["npm", "start"]
