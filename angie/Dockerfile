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

FROM docker.angie.software/angie:minimal

COPY --from=nginx-docker-entrypoint / /
RUN ln -s /etc/angie /etc/nginx \
    && mkdir -p /etc/angie/conf.d \
    && mv /etc/angie/http.d/default.conf /etc/angie/conf.d/default.conf
COPY <<EOF /etc/angie/http.d/00-nginx-shim.conf
include /etc/angie/conf.d/*.conf;
EOF

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [ "angie", "-g", "daemon off;" ]
