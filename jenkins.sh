yum install java-21-amazon-corretto -y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/rpm-stable/jenkins.repo
yum install jenkins -y
systemctl enable jenkins
systemctl start jenkins
systemctl status jenkins
