#FROM hesap/aimpy
FROM hesap/aimpy:latest
#FROM hesap/aim_trials

MAINTAINER Mesut Karakoç <mesudkarakoc@gmail.com>

#USER main
USER ${NB_USER}
ENV HOME /home/main

ADD python_test.py /home/main/python_test.py

