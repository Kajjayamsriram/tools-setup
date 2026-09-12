#install hashicorp vault
sudo yum install -y yum-utils shadow-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum install vault -y

#run the vault to access from ui
vault server -dev -dev-listen-address="0.0.0.0:8200"
