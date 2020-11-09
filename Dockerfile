FROM node:12-stretch

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN wget -q -O - https://download.docker.com/linux/debian/gpg | apt-key add -
RUN echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list
RUN echo "deb http://deb.debian.org/debian stretch-backports main" > /etc/apt/sources.list.d/openjdk.list

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
    software-properties-common \
    p11-kit \
    google-chrome-stable -y

RUN apt install -t stretch-backports openjdk-11-jdk ca-certificates-java -y

RUN wget -q -O /tmp/maven.tgz http://ftp-stud.hs-esslingen.de/pub/Mirrors/ftp.apache.org/dist/maven/maven-3/3.6.1/binaries/apache-maven-3.6.1-bin.tar.gz
RUN tar xf /tmp/maven.tgz
RUN mv apache-maven-3.6.1 $HOME/maven
RUN rm /tmp/maven.tgz

RUN echo "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable" > /etc/apt/sources.list.d/docker.list
RUN curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
RUN chmod 755 /usr/local/bin/docker-compose
RUN apt update -yqqq
RUN apt install docker-ce -y

RUN wget -q -O /tmp/libpng12.deb http://mirrors.kernel.org/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1_amd64.deb \
  && dpkg -i /tmp/libpng12.deb \
  && rm /tmp/libpng12.deb

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*
RUN update-ca-certificates
RUN trust extract --overwrite --format=java-cacerts --filter=ca-anchors --purpose=server-auth /usr/lib/jvm/java-11-openjdk-amd64/lib/security/cacerts

ENV CHROME_BIN /usr/bin/chromium
ENV DISPLAY :99
ENV PATH=/root/maven/bin:${PATH}
