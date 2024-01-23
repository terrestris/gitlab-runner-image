FROM node:12-stretch

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

RUN echo "deb http://mirror.netcologne.de/debian/ oldoldstable main contrib non-free" > /etc/apt/sources.list.d/docker.list
RUN apt -y update && apt -y install openjdk-8-jdk

RUN wget -q -O /tmp/maven.tgz https://downloads.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
RUN tar xf /tmp/maven.tgz
RUN mv apache-maven-3.6.3 $HOME/maven
RUN rm /tmp/maven.tgz

RUN echo "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable" > /etc/apt/sources.list.d/docker.list
RUN curl -L https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
RUN chmod 755 /usr/local/bin/docker-compose
RUN apt -y update
RUN apt install docker-ce -y

RUN wget -q -O /tmp/libpng12.deb http://mirrors.kernel.org/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1_amd64.deb \
  && dpkg -i /tmp/libpng12.deb \
  && rm /tmp/libpng12.deb

RUN wget -q http://cdn.sencha.com/cmd/6.2.2.36/no-jre/SenchaCmd-6.2.2.36-linux-amd64.sh.zip
RUN unzip -q SenchaCmd-6.2.2.36-linux-amd64.sh.zip
RUN ./SenchaCmd-6.2.2.36-linux-amd64.sh -q
RUN rm SenchaCmd-6.2.2.36-linux-amd64.sh.zip
RUN rm SenchaCmd-6.2.2.36-linux-amd64.sh
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

ENV CHROME_BIN /usr/bin/chromium
ENV DISPLAY :99
ENV PATH=/root/maven/bin:${PATH}
