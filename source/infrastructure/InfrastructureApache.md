# Infrastructure Apache

## Default configuration for an Apache Vhost

```
<VirtualHost *:443>
        ServerName www.siteurl.com
        ServerAlias technical.alias.net

        DocumentRoot /data/services/web/<sitename>/site

        ProxyErrorOverride On
        ProxyPass /static-content/ !
        ProxyPass /errors/ !
        ProxyPass /server-status !
        ProxyPass         / ajp://localhost:8009/ keepalive=on timeout=3000 ttl=300
        ProxyPassReverse  / ajp://localhost:8009/

        ErrorDocument 403 /errors/403.html
        ErrorDocument 404 /errors/404.html
        ErrorDocument 500 /errors/500.html
        ErrorDocument 503 /errors/503.html

        AddOutputFilterByType DEFLATE application/x-javascript text/html text/xml text/css text/javascript

        AddDefaultCharset UTF-8
        AddCharset UTF-8 .js .css

        <Directory /data/services/web/<sitename>/site>
                Require all granted
        </Directory>

        SSLEngine on

        SSLProtocol all -SSLv3 -TLSv1 -TLSv1.1
        SSLCipherSuite SSLCipherSuite ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384
        SSLHonorCipherOrder on

        SSLCertificateFile /etc/httpd/ssl/<sitename>.crt
        SSLCertificateKeyFile /etc/httpd/ssl/<sitename>.key.unsecure
        SSLCACertificateFile /etc/httpd/ssl/ca-thawte.crt

        CustomLog /data/log/web/<sitename>-access_log combined
        ErrorLog /data/log/web/<sitename>-error_log
</VirtualHost>
```
