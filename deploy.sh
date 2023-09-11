# !/bin/bash

poetry run mkdocs build -c
ssh root@10.254.12.55 "rm -rf /home/robot/sloth-doc/*"
scp -r -O ./public/* root@10.254.12.55:/home/robot/sloth-doc/
