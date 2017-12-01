FROM weboaks/node-karma-protractor-chrome

RUN apt update
RUN apt upgrade -y
RUN apt install unzip -y
RUN wget -q http://cdn.sencha.com/cmd/6.2.2/no-jre/SenchaCmd-6.2.2-linux-amd64.sh.zip
RUN unzip SenchaCmd-6.2.2-linux-amd64.sh.zip
RUN ./SenchaCmd-6.2.2.36-linux-amd64.sh -q
RUN rm SenchaCmd-6.2.2-linux-amd64.sh.zip
RUN apt clean
