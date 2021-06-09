#!/bin/bash

domains=$(</etc/nginx/domains)
first_domain="$(cut -d',' -f1 <<<$domains)"

if [[ ! -f /var/www/certbot ]]; then
    mkdir -p /var/www/certbot
fi
certbot certonly \
        --config-dir "${LETSENCRYPT_DIR:-/etc/letsencrypt}" \
		--agree-tos \
		--domains $domains \
		--email "$LETS_ENCRYPT_EMAIL" \
		--expand \
		--noninteractive \
		--webroot \
		--webroot-path /var/www/certbot \
		$OPTIONS || true

if [[ -f "${LETSENCRYPT_DIR:-/etc/letsencrypt}/live/$first_domain/privkey.pem" ]]; then
    cp "${LETSENCRYPT_DIR:-/etc/letsencrypt}/live/$first_domain/privkey.pem" /usr/share/nginx/certificates/privkey.pem
    cp "${LETSENCRYPT_DIR:-/etc/letsencrypt}/live/$first_domain/fullchain.pem" /usr/share/nginx/certificates/fullchain.pem
    cp "${LETSENCRYPT_DIR:-/etc/letsencrypt}/live/$first_domain/chain.pem" /usr/share/nginx/certificates/chain.pem
fi
