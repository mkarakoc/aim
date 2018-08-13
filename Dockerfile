FROM hesap/aimpy:latest
#FROM hesap/aim_trials

MAINTAINER Mesut Karakoç <mesudkarakoc@gmail.com>

RUN export LD_LIBRARY_PATH=/home/main/pylibs/flint2:/home/main/pylibs/arb:$LD_LIBRARY_PATH

# password of main user is Docker!
# REF: https://stackoverflow.com/questions/28721699/root-password-inside-a-docker-container
RUN echo "main:Docker!" | chpasswd

USER main
ENV BASH_ENV="/home/main/.bashrc"
WORKDIR /home/main

ADD python_test.py /home/main/python_test.py

