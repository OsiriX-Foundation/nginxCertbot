#!/bin/bash

roothost="testrp1.kheops.online"
domaines=$(</etc/nginx/domaines)
first="$(cut -d',' -f2 <<<$domaines)"

echo "$first"
echo "$domaines"

if [[ ! -f /var/www/certbot ]]; then
    mkdir -p /var/www/certbot
fi
certbot certonly \
        --config-dir "${LETSENCRYPT_DIR:-/etc/letsencrypt}" \
		--agree-tos \
		--domains testrp1.kheops.online \
		--domains testrp2.kheops.online \
		--domains testrp3.kheops.online \
		--domains test2.kheops.online \
		--domains demo.kheops.online \
		--email "$LETS_ENCRYPT_EMAIL" \
		--expand \
		--noninteractive \
		--webroot \
		--webroot-path /var/www/certbot \
		$OPTIONS || true

if [[ -f "${LETSENCRYPT_DIR:-/etc/letsencrypt}/live/$roothost/privkey.pem" ]]; then
    cp "${LETSENCRYPT_DIR:-/etc/letsencrypt}/live/$roothost/privkey.pem" /usr/share/nginx/certificates/privkey.pem
    cp "${LETSENCRYPT_DIR:-/etc/letsencrypt}/live/$roothost/fullchain.pem" /usr/share/nginx/certificates/fullchain.pem
    cp "${LETSENCRYPT_DIR:-/etc/letsencrypt}/live/$roothost/chain.pem" /usr/share/nginx/certificates/chain.pem
fi
