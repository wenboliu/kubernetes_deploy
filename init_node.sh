#!/bin/sh
cat <<EOF > kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=http://192.168.33.9/pub/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
EOF
sudo mv kubernetes.repo /etc/yum.repos.d/
sudo yum update -y
sudo setenforce 0
sudo yum install -y docker kubelet kubeadm kubectl kubernetes-cni
sudo systemctl enable docker
sudo rm -rf /etc/systemd/system/docker.service.d
sudo mkdir /etc/systemd/system/docker.service.d
rm -rf http-proxy.conf
echo "[Service]" > http-proxy.conf
echo "Environment=\"HTTP_PROXY=http://wenbo.liu:qazwsxedc1Q@114.215.237.86:7073\" \"HTTPS_PROXY=http://wenbo.liu:qazwsxedc1Q@114.215.237.86:7073\" \"NO_PROXY=localhost,127.0.0.1\"" >> http-proxy.conf
sudo mv http-proxy.conf /etc/systemd/system/docker.service.d/
sudo systemctl daemon-reload
sudo systemctl start docker
sudo systemctl enable kubelet
sudo systemctl start kubelet
