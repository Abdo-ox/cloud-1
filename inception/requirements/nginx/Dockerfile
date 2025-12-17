FROM debian:oldstable


RUN apt-get update -y && \
    apt-get install nginx -y && \
    apt-get install openssl -y

COPY ./conf/nginx.conf /etc/nginx

COPY ./tools/script.sh .

RUN mkdir -p /etc/nginx/ssl && \
    chmod 777 script.sh

EXPOSE 443

CMD ["./script.sh"]