FROM hesap/aimpy:latest
#FROM hesap/aim_trials

MAINTAINER Mesut Karakoç <mesudkarakoc@gmail.com>

# password of main user is Docker!
# REF: https://stackoverflow.com/questions/28721699/root-password-inside-a-docker-container
#RUN echo "main:Docker!" | chpasswd
ENV HOME = /home/main 

WORKDIR $HOME

USER main

ADD flint_test.ipynb  /home/main/flint_test.ipynb
