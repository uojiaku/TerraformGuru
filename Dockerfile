ARG NODE_VERSION=13-alpine

FROM node:$NODE_VERSION

ARG /usr/src/app

#RUN /usr/src/app

WORKDIR /usr/src/app

COPY ./project /usr/src/app

RUN npm install

EXPOSE 8080/tcp

VOLUME /var/lib/project

CMD node server.js

ENTRYPOINT [ ]