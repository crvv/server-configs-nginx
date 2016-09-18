server {
	listen  80;
    server_name omi.abc.com;
	location / {
		proxy_pass http://localhost:4480/;
	}
}
