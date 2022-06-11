FROM ubuntu:latest

SHELL ["/bin/bash", "-c"]
RUN touch ~/.bashrc && chmod +x ~/.bashrc

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

# Install NVM & Node LTS
RUN curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh" | bash
RUN . ~/.nvm/nvm.sh && source ~/.bashrc && nvm install --lts

# Install zsh
RUN mkdir -p ~/.antigen && \
    curl -L git.io/antigen > ~/.antigen/antigen.zsh
COPY .dockershell.sh /root/.zshrc
RUN /bin/bash -c "chown -R root:root ~/.antigen ~/.zshrc"
RUN /bin/zsh ~/.zshrc

WORKDIR /workspace

ENTRYPOINT ["/bin/zsh"]
