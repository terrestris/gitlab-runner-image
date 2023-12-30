FROM node:20-bullseye

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
  wget -q -O - https://download.docker.com/linux/debian/gpg | apt-key add - && \
  wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null && \
  echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list && \
  apt update -yqqq && \
  apt upgrade -y && \
  apt install unzip \
  temurin-21-jdk \
  rsync \
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
  libgbm1 libgbm-dev \
  libgif-dev \
  build-essential \
  g++ \
  apt-transport-https \
  ca-certificates \
  curl \
  wget \
  gnupg2 \
  software-properties-common -y && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*
