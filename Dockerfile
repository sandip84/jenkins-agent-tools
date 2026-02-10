FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
      ca-certificates \
      curl \
      unzip \
      git \
      bash \
      sed \
      groff \
      less && \
    rm -rf /var/lib/apt/lists/*

# AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf aws awscliv2.zip

# kubectl
RUN curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl && \
    install -m 0755 kubectl /usr/local/bin/kubectl && \
    rm kubectl

ENV PATH="/usr/local/bin:/usr/local/aws-cli/v2/current/bin:${PATH}"    
RUN aws --version && kubectl version --client && git --version

RUN useradd -m -s /bin/bash jenkins
USER jenkins
WORKDIR /home/jenkins
CMD ["cat"]
