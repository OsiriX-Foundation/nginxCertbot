#!/bin/bash

domaines=$(</etc/nginx/domaines)
first="$(cut -d',' -f1 <<<$domaines)"

echo "$first_domaine"
echo "$domaines"

if [[ ! -f /var/www/certbot ]]; then
    mkdir -p /var/www/certbot
fi
certbot certonly \
        --config-dir "${LETSENCRYPT_DIR:-/etc/letsencrypt}" \
		--agree-tos \
		--domains $domaines \
		--email "$LETS_ENCRYPT_EMAIL" \
		--expand \
		--noninteractive \
		--webroot \
		--webroot-path /var/www/certbot \
		$OPTIONS || true

if [[ -f "${LETSENCRYPT_DIR:-/etc/letsencrypt}/live/$first_domaine/privkey.pem" ]]; then
    cp "${LETSENCRYPT_DIR:-/etc/letsencrypt}/live/$first_domaine/privkey.pem" /usr/share/nginx/certificates/privkey.pem
    cp "${LETSENCRYPT_DIR:-/etc/letsencrypt}/live/$first_domaine/fullchain.pem" /usr/share/nginx/certificates/fullchain.pem
    cp "${LETSENCRYPT_DIR:-/etc/letsencrypt}/live/$first_domaine/chain.pem" /usr/share/nginx/certificates/chain.pem
fi
