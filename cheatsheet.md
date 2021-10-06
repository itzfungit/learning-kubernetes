# Kubernetes
https://kubernetes.io/docs/reference/kubectl/cheatsheet/

# kubectl Auto-completion
Bashsource <(kubectl completion bash)

alias k=kubectl

complete -F __start_kubectl k

# Jenkins Docker build server
sudo docker run --privileged --name=jenkins-master -d -p 8080:8080 -p50000:50000  -v  /jenkins_data:/var/jenkins_home jenkins/jenkins:lts-jdk11
