# !/bin/bash
ssh root@192.168.237.178 "rm -rf /usr/share/nginx/sloth-doc/*"
scp -r ./public/* root@192.168.237.178:/usr/share/nginx/sloth-doc/