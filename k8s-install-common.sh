sudo hostnamectl set-hostname $1
sudo apt-get update
sudo apt-get install -y net-tools

# Disable Firewall
sudo ufw disable

# Run this only on the master - Turn off SWAP
sudo swapoff -a
sed -i '/swap/d' /etc/fstab

# Time for Docker and K8s tools
echo "... Installing Docker ..."
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
echo "... Installing docker-compose ..."
sudo apt-get install -y docker-compose
echo "... Installing kubectl ..."
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
sudo echo '{"exec-opts": ["native.cgroupdriver=systemd"]}' | sudo tee /etc/docker/daemon.json
sudo systemctl daemon-reload
sudo systemctl restart docker
#sudo systemctl restart kubectl

# Update sysctl settings for K8s networking
cat >>/etc/sysctk.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system

# Mount NFS volume
sudo apt install -y nfs-common 
sudo mkdir /data
#sudo mount -t nfs 172.29.208.131:/NFS01 /data
#Modify /etc/fstab

#sudo kubeadm init --apiserver-advertise-address=172.29.218.191 --pod-network-cidr=192.168.0.0/16  --ignore-preflight-errors=all
#Deploy Calico network
#sudo kubectl --kubeconfig=/etc/kubernetes/admin.conf create -f https://docs.projectcalico.org/v3.20/manifests/calico.yaml

#Cluster join command
#sudo kubeadm token create --print-join-command
#sudo kubeadm join 172.29.218.191:6443 --token gzwud7.by5wggxe7gzwblk4 --discovery-token-ca-cert-hash sha256:6e868be961b3ce39ab63e4ccd309cc588f3b73c52bf2263cd3d47be9b3395d21

#If you want to be able to run kubectl commands as non-root user, then as a non-root user perform these
#mkdir -p $HOME/.kube
#sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
#sudo chown $(id -u):$(id -g) $HOME/.kube/config
