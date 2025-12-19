FROM debian:oldstable

ARG CERTS_PATH
ARG DOMAIN_NAME

RUN echo "$CERTS_PATH" && exit

RUN apt-get update -y && \
    apt-get install nginx -y && \
    apt-get install openssl -y

COPY ./conf/nginx.conf /etc/nginx

RUN mkdir -p $CERTS_PATH 

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ${CERTS_PATH}crt.key -out ${CERTS_PATH}crt.crt -subj "/C=MO/L=BG/O=1337/OU=student/CN=ajari.42.fr" > /dev/null 2>&1

RUN sed -i "s#/path/to/#$CERTS_PATH#g" /etc/nginx/nginx.conf \
    && sed -i "s#S_NAME#$DOMAIN_NAME#g" /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]