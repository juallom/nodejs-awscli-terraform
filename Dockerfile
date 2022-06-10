FROM ubuntu:latest

SHELL ["/bin/bash", "--login", "-c"]

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gnupg \
    software-properties-common \
    curl \
    unzip

# Install NVM
SHELL ["/bin/bash", "--login", "-i", "-c"]
RUN curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh" | bash

# Install Node.js LTS and NPM
RUN source ~/.bashrc && nvm install --lts
SHELL ["/bin/bash", "--login", "-c"]

# Install Terraform
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
RUN apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
RUN apt-get update && apt-get install -y terraform

# Install AWS-CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscli.zip"
RUN unzip awscli.zip
RUN ./aws/install
RUN rm -rf ./aws ./awscli.zip

RUN mkdir /workspace
WORKDIR /workspace
