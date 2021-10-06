# Kubernetes
https://kubernetes.io/docs/reference/kubectl/cheatsheet/

# kubectl Auto-completion
#Bash
source <(kubectl completion bash)
echo 'source <(kubectl completion bash)' >>~/.bashrc
alias k=kubectl
complete -F __start_kubectl k
https://www.padok.fr/en/blog/kubernetes-productivity-tips


# Jenkins Docker build server
sudo docker run --privileged --name=jenkins-master -d -p 8080:8080 -p50000:50000  -v  /jenkins_data:/var/jenkins_home jenkins/jenkins:lts-jdk11
