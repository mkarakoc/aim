FROM hesap/aimpy:latest
#FROM hesap/aim_trials

MAINTAINER Mesut Karakoç <mesudkarakoc@gmail.com>

#RUN passwd --delete main
RUN echo "main:Docker!" | chpasswd

USER main
#ENV HOME /home/main
ENV BASH_ENV="/root/.bashrc"
WORKDIR /home/main

ADD python_test.py /home/main/python_test.py

