#FROM hesap/aimpy
FROM hesap/aimpy:latest

MAINTAINER Mesut Karakoç <mesudkarakoc@gmail.com>

USER main
ENV HOME /home/main

ADD python_test.py /home/main/python_test.py

