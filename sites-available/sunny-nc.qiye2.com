server {

    listen 443 ssl http2 deferred fastopen=2;
    listen [::]:443 ssl http2 deferred fastopen=2;

    server_name sunny-nc.qiye2.com;

    ssl_certificate      /etc/nginx/ssl/crt;
    ssl_certificate_key  /etc/nginx/ssl/key;
    include h5bp/directive-only/ssl.conf;

    # Specify a charset
    charset utf-8;

    # Custom 404 page
    error_page 404 /404.html;

    # Include the basic h5bp config set
    include h5bp/basic.conf;

}
server {
    listen 80;
    location ^~ /pos/ {
        proxy_pass https://sunny-pos.qiye2.com/api/app_88/;
    }
}
