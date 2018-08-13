FROM hesap/aimpy:latest
#FROM hesap/aim_trials

MAINTAINER Mesut Karakoç <mesudkarakoc@gmail.com>

RUN useradd -ms /bin/bash newuser
USER newuser
WORKDIR /home/newuser

# password of main user is Docker!
# REF: https://stackoverflow.com/questions/28721699/root-password-inside-a-docker-container
RUN echo "main:Docker!" | chpasswd
ENV HOME=/home/main
WORKDIR $HOME

USER main

#CMD ["su", "-", "main", "-c", "/bin/bash"]
#RUN export LD_LIBRARY_PATH=/home/main/pylibs/flint2:/home/main/pylibs/arb:$LD_LIBRARY_PATH

ADD python_test.py /home/main/python_test.py
ADD flint_test.ipynb  /home/main/flint_test.ipynb
