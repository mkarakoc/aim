FROM hesap/aimpy
#FROM hesap/aim_trials:latest

MAINTAINER Mesut Karakoç <mesudkarakoc@gmail.com>

USER root

# password of main user is Docker!
# REF: https://stackoverflow.com/questions/28721699/root-password-inside-a-docker-container
#RUN echo "main:Docker!" | chpasswd

WORKDIR /home/main 

USER main

ADD flint_test.ipynb  /home/main/flint_test.ipynb
###############
# A BETTER EXAMPLE TO CREATE MYBINDER INTERACTIVE NOTEBOOKS
###############
###  https://github.com/jupyterhub/binder/blob/master/doc/sample_repos.md
###############
