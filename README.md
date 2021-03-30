# nginxCertbot

bind a volume :
/etc/nginx/reverse_proxy/host1.conf
/etc/nginx/reverse_proxy/host2.conf

```
server {
    listen 443 ssl http2;
    server_name test2.kheops.online;

    location / {
      proxy_pass http://10.5.5.28:8088;
      proxy_redirect http://10.5.5.28:8088 https://test2.kheops.online;
    }
}
```


/etc/nginx/domaines    `domaines` is a file with all hostname seperate by a COMMA




https://certbot.eff.org/docs/using.html#nginx

avoir plusieurs domaines : 


 -d DOMAIN, --domains DOMAIN, --domain DOMAIN
                        Domain names to apply. For multiple domains you can
                        use multiple -d flags or enter a comma separated list
                        of domains as a parameter. The first domain provided
                        will be the subject CN of the certificate, and all
                        domains will be Subject Alternative Names on the
                        certificate. The first domain will also be used in
                        some software user interfaces and as the file paths
                        for the certificate and related material unless
                        otherwise specified or you already have a certificate
                        with the same name. In the case of a name collision it
                        will append a number like 0001 to the file path name.
                        (default: Ask)
                        
                        
                        
Un fichier ou un secret sans extention "domaines" avec un domaine par ligne et la première ligne le domaine principal 

et un répertoire avec les serveurs (un serveur par fichier)  
