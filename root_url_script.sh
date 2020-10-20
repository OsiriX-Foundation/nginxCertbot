#!/bin/bash


if [[ -z $NGINX_ROOT_URL ]]; then
  echo "Missing NGINX_ROOT_URL environment variable"
  exit 1
else
   echo -e "environment variable NGINX_ROOT_URL \e[92mOK\e[0m"
   touch /var/nginx_root_url
   echo "$NGINX_ROOT_URL" > /var/nginx_root_url
fi


if [[ -f /var/nginx_root_url ]]; then
  word_count=$(wc -w /var/nginx_root_url | cut -f1 -d" ")
  line_count=$(wc -l /var/nginx_root_url | cut -f1 -d" ")

  if [ ${word_count} != 1 ] || [ ${line_count} != 1 ]; then
    echo Error with /var/nginx_root_url. He contains $word_count word and $line_count line
    exit 1
  fi
else
  exit 1
fi
