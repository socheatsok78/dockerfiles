# FROM node:20-alpine AS angie-console
# ADD https://github.com/webserver-llc/angie-console-light.git /src
# WORKDIR /src
# RUN corepack disable && corepack enable
# RUN yarn install
# RUN yarn build

FROM --platform=$BUILDPLATFORM nginx:stable-alpine AS nginx

# Modify all files in /docker-entrypoint.d by replacing "etc/nginx" with "etc/angie"
RUN sed -i 's/nginx/angie/g' /docker-entrypoint.sh
RUN find /docker-entrypoint.d -type f -exec sed -i 's/etc\/nginx/etc\/angie/g' {} \;
RUN find /docker-entrypoint.d -type f -exec sed -i 's/nginx.conf/angie.conf/g' {} \;
RUN rm /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh

FROM --platform=$BUILDPLATFORM scratch AS nginx-docker-entrypoint
COPY --from=nginx /docker-entrypoint.sh /docker-entrypoint.sh
COPY --from=nginx /docker-entrypoint.d /docker-entrypoint.d

FROM docker.angie.software/angie:latest AS angie-console-light

FROM docker.angie.software/angie:minimal


ADD rootfs /
RUN apk add --no-cache envsubst

COPY --from=angie-console-light /usr/share/angie-console-light /usr/share/angie-console-light
COPY --from=nginx-docker-entrypoint / /
RUN ln -s /etc/angie /etc/nginx \
    && ln -s /var/log/angie /var/log/nginx \
    && mv /etc/angie/http.d/ /etc/angie/conf.d/ \
    && rm -rf /etc/angie/stream.d

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [ "angie", "-g", "daemon off;" ]
