FROM hesap/aimpy:latest
#FROM hesap/aim_trials

MAINTAINER Mesut Karakoç <mesudkarakoc@gmail.com>

RUN passwd --delete main

USER main
#ENV HOME /home/main
RUN source /home/main/.bashrc
WORKDIR /home/main

ADD python_test.py /home/main/python_test.py

