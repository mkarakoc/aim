FROM hesap/aimpy

USER main

ADD python_test.py python_test.py
RUN mv python_test.py /home/main/
