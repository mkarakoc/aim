# https://hub.docker.com/r/hesap/
FROM hesap/aimpy:main202002270048

MAINTAINER Mesut Karakoç <mesudkarakoc@gmail.com>

ADD examples    /home/main/examples
RUN chown -R main:main /home/main/examples

# main user
USER main

# working directory
WORKDIR /home/main

