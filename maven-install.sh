yum install java-21-amazon-corretto -y
wget https://dlcdn.apache.org/maven/maven-3/3.9.16/binaries/apache-maven-3.9.16-bin.tar.gz
tar -xzvf apache-maven-3.9.16-bin.tar.gz 
mv apache-maven-3.9.16 /opt/mvn
export PATH=$PATH:/opt/mvn/bin
mvn -v
