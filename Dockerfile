FROM hesap/aimpy:latest
#FROM hesap/aim_trials

MAINTAINER Mesut Karakoç <mesudkarakoc@gmail.com>

# password of main user is Docker!
# REF: https://stackoverflow.com/questions/28721699/root-password-inside-a-docker-container
RUN echo "main:Docker!" | chpasswd

USER main
ENV BASH_ENV="/home/main/.bashrc"
WORKDIR /home/main

ADD python_test.py /home/main/python_test.py

