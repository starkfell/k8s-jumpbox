FROM ubuntu:18.04

MAINTAINER Ryan Irujo "starkfell.github.io"

ENV DEBIAN_FRONTEND noninteractive

# Installing Prerequisites
RUN apt-get update && \
apt-get -y install --no-install-recommends \
docker.io \
vim \
jq \
curl \
wget \
git \
unzip \
expect \
debconf-utils \
apt-transport-https \
ca-certificates \
gnupg \
lsb-release \
net-tools \
iputils-ping \
dnsutils \
sshpass \
telnet \
tcpdump \
nmap

# Installing Azure CLI
RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null  && \
AZ_REPO=$(lsb_release -cs) && \
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | tee /etc/apt/sources.list.d/azure-cli.list  && \
apt-get update && \
apt-get install -y --no-install-recommends \
azure-cli

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
