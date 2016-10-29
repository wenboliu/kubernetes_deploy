#!/bin/sh
sudo yum update -y
sudo yum install -y docker
sudo systemctl enable docker.service
sudo rm -rf /etc/systemd/system/docker.service.d
sudo mkdir /etc/systemd/system/docker.service.d
rm -rf http-proxy.conf
echo "[Service]" > http-proxy.conf
echo "Environment=\"HTTP_PROXY=http://wenbo.liu:qazwsxedc1Q@114.215.237.86:7073\" \"HTTPS_PROXY=http://wenbo.liu:qazwsxedc1Q@114.215.237.86:7073\" \"NO_PROXY=localhost,127.0.0.1\"" >> http-proxy.conf
sudo mv http-proxy.conf /etc/systemd/system/docker.service.d/
sudo systemctl daemon-reload
sudo systemctl start docker
sudo docker pull wenboliu/kubernetes_yumrepo
sudo docker run -d -p 80:80 wenboliu/kubernetes_yumrepo
sudo docker ps -a
