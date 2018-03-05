FROM node:8-stretch

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list

RUN apt update -yqqq
RUN apt upgrade -y
RUN apt install unzip \
    rsync \
    openjdk-8-jdk \
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
    google-chrome-stable -y

RUN wget -q -O /tmp/libpng12.deb http://mirrors.kernel.org/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1_amd64.deb \
  && dpkg -i /tmp/libpng12.deb \
  && rm /tmp/libpng12.deb

RUN wget -q http://cdn.sencha.com/cmd/6.2.2/no-jre/SenchaCmd-6.2.2-linux-amd64.sh.zip
RUN unzip SenchaCmd-6.2.2-linux-amd64.sh.zip
RUN ./SenchaCmd-6.2.2.36-linux-amd64.sh -q
RUN rm SenchaCmd-6.2.2-linux-amd64.sh.zip
RUN rm SenchaCmd-6.2.2.36-linux-amd64.sh
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

ENV CHROME_BIN /usr/bin/chromium
ENV DISPLAY :99
