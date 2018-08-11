FROM hesap/aimpy:latest

USER main
ENV HOME /home/main

ADD python_test.py /home/main/python_test.py

