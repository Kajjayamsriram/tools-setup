cd /opt/; wget https://download.sonatype.com/nexus/3/nexus-3.93.1-04-linux-x86_64.tar.gz
tar -xzvf nexus-3.93.1-04-linux-x86_64.tar.gz

useradd nexus
chown nexus:nexus /opt/nexus-3.93.1-04/ /opt/sonatype-work/ -R
su - nexus /opt/nexus-3.93.1-04/bin/nexus start
