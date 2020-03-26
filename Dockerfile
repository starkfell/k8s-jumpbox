FROM ubuntu:18.04

MAINTAINER Ryan Irujo "starkfell.github.io"

ENV DEBIAN_FRONTEND noninteractive

# Installing Prerequisites
RUN apt-get update && \
apt-get -y install \
vim \
jq \
curl \
wget \
git \
unzip \
expect \
debconf-utils \
apt-transport-https \
lsb-release \
net-tools \
iputils-ping \
dnsutils \
sshpass \
telnet \
tcpdump \
nmap

# Installing kubectl
RUN curl -s -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
chmod +x ./kubectl && \
mv ./kubectl /usr/local/bin/kubectl

# Copying kuard binary to '/' and making it executable.
COPY kuard-app/kuard /kuard
RUN chmod +x ./kuard

EXPOSE 8080

# Starting kuard.
ENTRYPOINT ["/kuard"]
