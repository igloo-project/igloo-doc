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

        SSLProtocol all -SSLv2 -SSLv3
        SSLCipherSuite ALL:!ADH:!EXPORT:!SSLv2:RC4+RSA:+HIGH:+MEDIUM:+LOW

        SSLCertificateFile /etc/httpd/ssl/<sitename>.crt
        SSLCertificateKeyFile /etc/httpd/ssl/<sitename>.key.unsecure
        SSLCACertificateFile /etc/httpd/ssl/ca-thawte.crt

        CustomLog /data/log/web/<sitename>-access_log combined
        ErrorLog /data/log/web/<sitename>-error_log
</VirtualHost>
```
