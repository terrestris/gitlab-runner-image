FROM node:20-bookworm

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN wget -q -O - https://download.docker.com/linux/debian/gpg | apt-key add -

RUN apt update -yqqq
RUN apt upgrade -y
RUN apt install unzip \
    rsync \
    xvfb \
    ssh-askpass \
    openssh-client \
    ca-certificates \
    libgif-dev \
    libgconf-2-4 \
    chromium \
    libcairo2-dev \
    libjpeg-dev \
    libpango1.0-dev \
    libgif-dev \
    build-essential \
    g++ \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common -y

RUN apt -y update && \
    wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor -o /usr/share/keyrings/adoptium-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/adoptium-archive-keyring.gpg] https://packages.adoptium.net/artifactory/deb $(lsb_release -cs) main" > /etc/apt/sources.list.d/adoptium.list && \
    apt update -y && \
    apt install -y temurin-8-jdk

RUN wget -q -O /tmp/maven.tgz https://downloads.apache.org/maven/maven-3/3.8.9/binaries/apache-maven-3.8.9-bin.tar.gz
RUN tar xf /tmp/maven.tgz
RUN mv apache-maven-3.8.9 $HOME/maven
RUN rm /tmp/maven.tgz

RUN install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc
RUN echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt update -yqqq
RUN apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

RUN wget -q https://cdn.sencha.com/cmd/6.2.2.36/no-jre/SenchaCmd-6.2.2.36-linux-amd64.sh.zip
RUN unzip -q SenchaCmd-6.2.2.36-linux-amd64.sh.zip
RUN ./SenchaCmd-6.2.2.36-linux-amd64.sh -q
RUN rm SenchaCmd-6.2.2.36-linux-amd64.sh.zip
RUN rm SenchaCmd-6.2.2.36-linux-amd64.sh
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

ENV CHROME_BIN=/usr/bin/chromium
ENV DISPLAY=:99
ENV PATH=/root/maven/bin:${PATH}
