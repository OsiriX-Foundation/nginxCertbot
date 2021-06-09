#!/bin/bash

### Let's Encrypt
# based on https://ilhicas.com/2019/03/02/Nginx-Letsencrypt-Docker.html
# Create a self signed default certificate, so Ngix can start before we have
# any real certificates.

#Ensure we have folders available

if [[ ! -f /usr/share/nginx/certificates/fullchain.pem ]];then
    mkdir -p /usr/share/nginx/certificates
fi

domains=$(</etc/nginx/domains)
first_domain="$(cut -d',' -f1 <<<$domains)"

### If we already have certbot generated certificates, copy them over
if [[ -f "${LETSENCRYPT_DIR:-/etc/letsencrypt}/live/$first_domain/privkey.pem" ]]; then
    cp "${LETSENCRYPT_DIR:-/etc/letsencrypt}/live/$first_domain/privkey.pem" /usr/share/nginx/certificates/privkey.pem
    cp "${LETSENCRYPT_DIR:-/etc/letsencrypt}/live/$first_domain/fullchain.pem" /usr/share/nginx/certificates/fullchain.pem
    cp "${LETSENCRYPT_DIR:-/etc/letsencrypt}/live/$first_domain/chain.pem" /usr/share/nginx/certificates/chain.pem
else
    openssl genrsa -out /usr/share/nginx/certificates/privkey.pem 4096
    openssl req -new -key /usr/share/nginx/certificates/privkey.pem -out /usr/share/nginx/certificates/cert.csr -nodes -subj \
    "/C=PT/ST=World/L=World/O=$first_domain/OU=kheops lda/CN=${first_domain}"
    openssl x509 -req -days 365 -in /usr/share/nginx/certificates/cert.csr -signkey /usr/share/nginx/certificates/privkey.pem -out /usr/share/nginx/certificates/fullchain.pem
    cp /usr/share/nginx/certificates/fullchain.pem /usr/share/nginx/certificates/chain.pem
fi

### Send certbot Emission/Renewal to background
$(while :; do /opt/certbot.sh; sleep "12h"; done;) &

### Check for changes in the certificate (i.e renewals or first start) and send this process to background
$(while inotifywait -e close_write /usr/share/nginx/certificates; do nginx -s reload; done) &
