FROM node:16-alpine AS build
RUN apk add --no-cache libc6-compat
WORKDIR /dist/src/app
COPY . .
RUN yarn install
RUN yarn build

FROM    nginx:1.21.4-alpine
ARG     dist
RUN     echo "http://uk.alpinelinux.org/alpine/v3.8/main" > /etc/apk/repositories ; \
    echo "http://uk.alpinelinux.org/alpine/v3.8/community" >> /etc/apk/repositories ; \
    apk add --no-cache bash ; \
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.8/main" > /etc/apk/repositories ; \
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.8/community" >> /etc/apk/repositories
COPY    ./entrypoint.sh /entrypoint.sh
RUN     echo ${conf}
COPY    ./default.conf /etc/nginx/conf.d/default.conf
WORKDIR /usr/share/nginx/html
COPY     --from=build /dist/src/app/dist /usr/share/nginx/html
EXPOSE  80
RUN     chmod +x /entrypoint.sh
CMD     [ "/entrypoint.sh" ]