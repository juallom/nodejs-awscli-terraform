FROM ubuntu:latest

ENV RUNNING_IN_DOCKER true

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gnupg \
    software-properties-common \
    curl \
    unzip \
    git \
    zsh

# Install Terraform
RUN curl https://apt.releases.hashicorp.com/gpg | apt-key add -
RUN apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
RUN apt-get update && apt-get install -y terraform

# Install AWS-CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscli.zip"
RUN unzip awscli.zip
RUN ./aws/install
RUN rm -rf ./aws ./awscli.zip

# Install NVM
RUN curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh" | bash

# Install zsh
RUN mkdir -p ~/.antigen && \
    curl -L git.io/antigen > ~/.antigen/antigen.zsh

COPY .dockershell.sh /root/.zshrc
RUN /bin/bash -c "chown -R root:root ~/.antigen ~/.zshrc"
RUN /bin/zsh ~/.zshrc

# Install Node.js LTS and NPM
CMD /bin/bash -c "source ~/.bashrc && nvm install --lts"

WORKDIR /workspace

CMD /bin/zsh
