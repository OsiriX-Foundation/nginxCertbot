FROM nginx:1.19.8

RUN apt-get update &&  apt-get install -y inotify-tools certbot openssl
COPY certbot.sh /opt/certbot.sh
ENV LETS_ENCRYPT_EMAIL=spalte@naturalimage.ch


COPY rp.conf /etc/nginx/conf.d/rp.conf
COPY nginx_certbot_script.sh /docker-entrypoint.d/90-nginx_certbot_script.sh
COPY ssl_cert.conf /etc/nginx/conf.d/ssl_cert.conf
COPY acme_challenge_port80.conf /etc/nginx/conf.d/acme_challenge_port80.conf

CMD ["nginx", "-g", "daemon off;"]
