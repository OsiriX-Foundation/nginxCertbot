# nginxCertbot

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
