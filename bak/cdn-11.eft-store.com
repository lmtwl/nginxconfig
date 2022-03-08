server {
    listen 29934;
    #  listen 80  reuseport;
    server_name cdn-11.eft-store.com;
    access_log /data/nginx/logs/access.log cachelog;
    error_log /data/nginx/logs/error.log;

    #resolver 202.181.224.2 203.198.7.66 ipv6=off;
    resolver 127.0.0.1 ipv6=off;

    location ~ ^.+(releaselisting_.*|.version$|_version$|.ver$|.json$|.config$) {
        expires 30s;
        proxy_pass http://$host;
    }
    location ~* \.config$ {
        include generic.d/root/*.conf;
    }
    location ~* ^/(ClientUpdates|ClientDistribs|LauncherDistribs)/ {
        include generic.d/root/*.conf;
    }
     location ~* ^\/client/live/distribs/ {
         include generic.d/root/*.conf;
     }
    location / {
        include generic.d/root_followsource/*.conf;
    }
}
