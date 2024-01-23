FROM node:12-buster

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN wget -q -O - https://download.docker.com/linux/debian/gpg | apt-key add -

RUN apt -y update
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

RUN curl 'https://objects.githubusercontent.com/github-production-release-asset-2e65be/372924428/a6024786-543c-44a7-8594-4f25c5ed0f14?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAVCODYLSA53PQK4ZA%2F20240123%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240123T102037Z&X-Amz-Expires=300&X-Amz-Signature=4ff47fd0b9fb514ecad28ef9176999069dcef73127c80ce9c2f9d4d61b9ab204&X-Amz-SignedHeaders=host&actor_id=0&key_id=0&repo_id=372924428&response-content-disposition=attachment%3B%20filename%3DOpenJDK8U-jdk_x64_linux_hotspot_8u402b06.tar.gz&response-content-type=application%2Foctet-stream' -o /tmp/jdk.tgz
RUN tar xf /tmp/jdk.tgz

RUN wget -q -O /tmp/maven.tgz https://downloads.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz
RUN tar xf /tmp/maven.tgz
RUN mv apache-maven-3.9.6 $HOME/maven
RUN rm /tmp/maven.tgz

RUN echo "deb [arch=amd64] https://download.docker.com/linux/debian buster stable" > /etc/apt/sources.list.d/docker.list
RUN curl -L https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
RUN chmod 755 /usr/local/bin/docker-compose
RUN apt -y update
RUN apt install docker-ce -y

RUN wget -q -O /tmp/libpng12.deb http://mirrors.kernel.org/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1_amd64.deb \
  && dpkg -i /tmp/libpng12.deb \
  && rm /tmp/libpng12.deb

RUN wget -q http://cdn.sencha.com/cmd/6.2.2.36/no-jre/SenchaCmd-6.2.2.36-linux-amd64.sh.zip
RUN unzip -q SenchaCmd-6.2.2.36-linux-amd64.sh.zip
RUN export INSTALL4J_JAVA_HOME=/jdk8u402-b06/ && ./SenchaCmd-6.2.2.36-linux-amd64.sh -q
RUN rm SenchaCmd-6.2.2.36-linux-amd64.sh.zip
RUN rm SenchaCmd-6.2.2.36-linux-amd64.sh
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

ENV CHROME_BIN /usr/bin/chromium
ENV DISPLAY :99
ENV PATH=/root/maven/bin:${PATH}
ENV JAVA_HOME=/jdk8u402-b06/
