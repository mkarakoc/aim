FROM hesap/aimpy:jovyan_20180815_1139

MAINTAINER Mesut Karakoç <mesudkarakoc@gmail.com>

USER root

### password of main user is Docker!
### REF: https://stackoverflow.com/questions/28721699/root-password-inside-a-docker-container
RUN echo "jovyan:Docker!" | chpasswd

USER jovyan

ENV LD_LIBRARY_PATH "${LD_LIBRARY_PATH}:/home/jovyan/pylibs/flint2:/home/jovyan/pylibs/arb"
ENV SHELL "/bin/bash"
WORKDIR /home/jovyan

ADD flint_test.ipynb  /home/jovyan/flint_test.ipynb
