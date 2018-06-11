# docker_nodejs
#
# VERSION               1.0.0

FROM daocloud.io/node:5
MAINTAINER 18810042351@163.com

ENV HTTP_PORT 8000

COPY . /app
WORKDIR /app

RUN npm install

EXPOSE 8000

CMD ["npm", "start"]
