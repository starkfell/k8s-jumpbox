# Shodan CLI Docker Container

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
apt-transport-https \
lsb-release \

# Installing kubectl
RUN curl -s -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl

ENTRYPOINT ["tail", "-f", "/dev/null"]
