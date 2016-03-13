server {

    listen 443 ssl http2 deferred fastopen=2;
    listen [::]:443 ssl http2 deferred fastopen=2;

    server_name okr.qiye2.com;

    ssl_certificate      /etc/nginx/ssl/crt;
    ssl_certificate_key  /etc/nginx/ssl/key;
    include h5bp/directive-only/ssl.conf;

    # Path for static files
    # root /var/www/example.com/public;

    # Specify a charset
    charset utf-8;

    # Custom 404 page
    error_page 404 /404.html;

    # Include the basic h5bp config set
    include h5bp/basic.conf;

    location ^~ /wechat/ {
        proxy_pass http://localhost:5000/;
    }
    location ^~ /api/ {
        include h5bp/directive-only/cross-domain-insecure.conf;
        proxy_pass http://localhost:3000/;
    }
    location ^~ / {
        root /home/skyline/skyline-okr;
    }
}
