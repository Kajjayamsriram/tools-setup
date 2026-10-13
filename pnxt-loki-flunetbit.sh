#Loki
apt update -y
apt install docker.io -y
wget https://raw.githubusercontent.com/grafana/loki/v3.7.0/cmd/loki/loki-local-config.yaml -O loki-config.yaml
docker run --name loki -d -v $(pwd):/mnt/config -p 3100:3100 grafana/loki:3.7.0 -config.file=/mnt/config/loki-config.yaml
docker container ls

#Fluentbit( or promtail)
sudo apt-get update
sudo apt-get install -y curl gnupg
curl -fsSL https://packages.fluentbit.io/fluentbit.key \
  | sudo gpg --dearmor \
  -o /usr/share/keyrings/fluentbit-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/fluentbit-keyring.gpg] https://packages.fluentbit.io/ubuntu/$(lsb_release -cs) $(lsb_release -cs) main" \
  | sudo tee /etc/apt/sources.list.d/fluent-bit.list

sudo cp /etc/fluent-bit/fluent-bit.conf \
  /etc/fluent-bit/fluent-bit.conf.bak
sudo vi /etc/fluent-bit/fluent-bit.conf


sudo systemctl enable --now fluent-bit
sudo systemctl restart fluent-bit
sudo systemctl status fluent-bit --no-pager

curl -s http://loki:3100/ready
