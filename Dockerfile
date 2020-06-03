FROM node:12-buster

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN wget -q -O - https://download.docker.com/linux/debian/gpg | apt-key add -

RUN apt update -yqqq
RUN apt upgrade -y
RUN apt install unzip \
    rsync \
    openjdk-11-jdk \
    xvfb \
    maven \
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

RUN echo "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable" > /etc/apt/sources.list.d/docker.list
RUN curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
RUN chmod 755 /usr/local/bin/docker-compose
RUN apt update -yqqq
RUN apt install docker-ce -y

RUN wget -q -O /tmp/libpng12.deb http://mirrors.kernel.org/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1_amd64.deb \
  && dpkg -i /tmp/libpng12.deb \
  && rm /tmp/libpng12.deb

RUN wget -q http://cdn.sencha.com/cmd/6.7.0.63/no-jre/SenchaCmd-6.7.0.63-linux-amd64.sh.zip
RUN unzip -q SenchaCmd-6.7.0.63-linux-amd64.sh.zip
RUN ./SenchaCmd-6.7.0.63-linux-amd64.sh -q
RUN rm SenchaCmd-6.7.0.63-linux-amd64.sh.zip
RUN rm SenchaCmd-6.7.0.63-linux-amd64.sh
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

ENV CHROME_BIN /usr/bin/chromium
ENV DISPLAY :99
