FROM example/node:base AS node

RUN mkdir -p /app
COPY ./ /app
RUN npm install && npm run production

# --------- Main Image --------- #
FROM example/nginx

# Copy Config
COPY docker/nginx/conf.d/* /etc/nginx/conf.d/

# Copy codebase
WORKDIR /var/www
RUN mkdir -p /var/www/public && mkdir -p /var/www/storage
COPY --from=node /app/public /var/www/public/

EXPOSE 80 443

CMD [ "nginx", "-g", "daemon off;" ]