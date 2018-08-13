FROM hesap/aimpy:latest
#FROM hesap/aim_trials

MAINTAINER Mesut Karakoç <mesudkarakoc@gmail.com>

#https://stackoverflow.com/questions/27701930/add-user-to-docker-container
#RUN useradd -ms /bin/bash newuser
#USER newuser
#WORKDIR /home/newuser
#ADD python_test.py /home/newuser/python_test.py
#ADD flint_test.ipynb  /home/newuser/flint_test.ipynb


# password of main user is Docker!
# REF: https://stackoverflow.com/questions/28721699/root-password-inside-a-docker-container
RUN echo "main:Docker!" | chpasswd
ENV HOME = /home/main 

WORKDIR $HOME

#COPY start.sh /usr/local/bin/
#CMD ["start.sh"]


USER main

#RUN export LD_LIBRARY_PATH=/home/main/pylibs/flint2:/home/main/pylibs/arb:$LD_LIBRARY_PATH

ADD flint_test.ipynb  /home/main/flint_test.ipynb
