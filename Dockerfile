FROM hesap/jupyter
#FROM hesap/aimpy:latest
#FROM hesap/aim_trials:latest

MAINTAINER Mesut Karakoç <mesudkarakoc@gmail.com>

###################
USER root
###################

# See https://github.com/sagemathinc/cocalc/issues/921
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV TERM screen
ENV export LD_LIBRARY_PATH=/home/main/pylibs/flint2:/home/main/pylibs/arb:$LD_LIBRARY_PATH

## create password-less user
RUN useradd -m main2 && echo "main2:mai2n" | chpasswd && adduser main2 sudo
RUN echo "main2:main2" | chpasswd && adduser main2 sudo

#### without password
RUN passwd --delete main2

#### MAIN USER ####
USER main2
###################
WORKDIR /home
