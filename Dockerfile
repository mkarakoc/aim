#FROM hesap/aimpy
FROM hesap/aimpy:latest
#FROM hesap/aim_trials

MAINTAINER Mesut Karakoç <mesudkarakoc@gmail.com>

USER root

USER main

ENV HOME /home/main

ADD python_test.py /home/main/python_test.py

