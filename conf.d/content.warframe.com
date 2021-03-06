server {
    listen 17980;
    #listen 80  reuseport;
    server_name content.warframe.com;
    access_log /data/nginx/logs/access.log cachelog;
    error_log /data/nginx/logs/error.log;
    resolver 127.0.0.1 ipv6=off;
    location / {
       include generic.d/http-nocache-noexpires/*.conf;
    }
}
