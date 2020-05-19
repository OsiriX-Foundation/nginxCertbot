FROM nginx:stable

ENV SECRET_FILE_PATH=/run/secrets

RUN apt-get update &&  apt-get install -y inotify-tools certbot openssl
COPY certbot.sh /opt/certbot.sh
RUN chmod +x /opt/certbot.sh 
ENV LETS_ENCRYPT_EMAIL=spalte@naturalimage.ch

COPY nginx_certbot_script.sh /etc/nginx/conf.d/nginx_certbot_script.sh
RUN chmod +x /etc/nginx/conf.d/nginx_certbot_script.sh 
COPY ssl_cert.conf /etc/nginx/conf.d/ssl_cert.conf
COPY acme_challenge_port80.conf /etc/nginx/conf.d/acme_challenge_port80.conf

ENTRYPOINT /etc/nginx/conf.d/nginx_certbot_script.sh
