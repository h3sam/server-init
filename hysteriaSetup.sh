#!/bin/bash

apt update && apt upgrade -y
bash <(curl -fsSL https://get.hy2.sh/)
HYSTERIA_USER=root bash <(curl -fsSL https://get.hy2.sh/)
openssl ecparam -name prime256v1 -out params.pem
openssl req -x509 -nodes -days 3650 -newkey ec:params.pem -keyout key.pem -out cert.pem -subj "/CN=Hysteria2"
apt install nano vim -y
echo 'listen: :9543

tls:
  cert: cert.pem
  key: key.pem

obfs:
  type: salamander
  salamander:
    password: H3ll0k!tty

quic:
  initStreamReceiveWindow: 8388608
  maxStreamReceiveWindow: 8388608
  initConnReceiveWindow: 20971520
  maxConnReceiveWindow: 20971520
  maxIdleTimeout: 30s
  maxIncomingStreams: 1024
  disablePathMTUDiscovery: false

bandwidth:
  up: 1 gbps
  down: 1 gbps

ignoreClientBandwidth: false

speedTest: false

disableUDP: false

udpIdleTimeout: 60s

auth:
  type: password
  password: H3ll0k!tty

resolver:
  type: udp
  tcp:
    addr: 8.8.8.8:53
    timeout: 4s
  udp:
    addr: 8.8.4.4:53
    timeout: 4s
  tls:
    addr: 1.1.1.1:853
    timeout: 10s
    sni: cloudflare-dns.com
    insecure: false
  https:
    addr: 1.1.1.1:443
    timeout: 10s
    sni: cloudflare-dns.com
    insecure: false

sniff:
  enable: true
  timeout: 2s
  rewriteDomain: false
  tcpPorts: 80,443,8000-9000
  udpPorts: all

masquerade:
  type: proxy
  proxy:
    url: https://news.ycombinator.com/
    rewriteHost: true' > /etc/hysteria/config.yaml
systemctl restart hysteria-server.service
systemctl enable --now hysteria-server.service
systemctl status hysteria-server.service
echo "if all things are working correctly, this would be your config link:\nhysteria2://H3ll0k!tty@$(hostname -I | awk '{print $1}'):9543?&insecure=1&obfs=salamander&obfs-password=H3ll0k!tty#yourVeryOwnVPN"

