#kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/kubectl
kubectl version --client

#eksctl
curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_Linux_amd64.tar.gz"
tar -xzf eksctl_Linux_amd64.tar.gz
sudo mv eksctl /usr/local/bin
eksctl version

#cluster creation
eksctl create cluster --name=srieks --region=us-east-2 --zones=us-east-2a,us-east-2b --without-nodegroup

#grant trust between AWS IAM
eksctl utils associate-iam-oidc-provider --region us-east-2 --cluster srieks --approve

#node group creation
eksctl create nodegroup --cluster=srieks --region=us-east-2 --name=srinodes --node-type=c7i-flex.large --nodes=2 \
 --nodes-min=2 --nodes-max=3 --node-volume-size=20 --ssh-access --ssh-public-key=skypia --managed --asg-access \ 
 --external-dns-access --full-ecr-access --appmesh-access --alb-ingress-access

#adding context for cluster access
aws eks update-kubeconfig --name srieks --region us-east-2

#list clusters
eksctl get clsuter --region=us-east-2 

#to delete a cluster
eksctl delete cluster srieks --region us-east-2
