FROM node:24-trixie

RUN wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null && \
  echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list && \
  apt update -yqqq && \
  apt upgrade -y && \
  apt install unzip \
  temurin-25-jdk \
  rsync \
  xvfb \
  maven \
  ssh-askpass \
  openssh-client \
  ca-certificates \
  libgif-dev \
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
  gnupg2 -y && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*
