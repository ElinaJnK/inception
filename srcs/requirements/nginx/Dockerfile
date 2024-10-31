FROM alpine:3.19

RUN apk update && \
    apk add --no-cache nginx

RUN mkdir -p /etc/nginx/ssl
RUN apk upgrade --update-cache --available && \
    apk add openssl && \
    rm -rf /var/cache/apk/*

# p-e mettre dans ssl
RUN openssl req -x509 -nodes -out /etc/nginx/inception.crt -keyout /etc/nginx/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=login.42.fr/UID=login"

RUN mkdir -p /var/run/nginx

COPY tools/nginx.conf /etc/nginx/nginx.conf

#RUN mkdir -p /var/www/html
#RUN chmod 755 /var/www/html
#RUN chown -R ejankovs /var/www/html

CMD [ "nginx", "-g", "daemon off;" ]