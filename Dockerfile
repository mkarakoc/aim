#FROM hesap/jupyter
FROM hesap/aimpy:jovyan_20180815_1139
#FROM hesap/aim_trials:latest

MAINTAINER Mesut Karakoç <mesudkarakoc@gmail.com>

#One or more build-args [NB_USER NB_UID] were not consumed
ARG NB_USER=jovyan
ARG NB_UID=1000
ENV HOME /home/${NB_USER}

USER root
#RUN chown -R ${NB_UID} ${HOME}
RUN echo "jovyan:Docker!" | chpasswd

USER ${NB_USER}

ENV LD_LIBRARY_PATH "${LD_LIBRARY_PATH}:/home/jovyan/pylibs/flint2:/home/jovyan/pylibs/arb"
ENV SHELL "/bin/bash"
WORKDIR /home/${NB_USER}

ADD flint_test.ipynb  /home/${NB_USER}/flint_test.ipynb

# adduser --disabled-password --gecos "Default user" --uid 1000 jovyan

#*******FROM hesap/jupyter
#*******FROM hesap/aimpy:latest
#*******#FROM hesap/aim_trials:latest
#*******
#*******MAINTAINER Mesut Karakoç <mesudkarakoc@gmail.com>
#*******
#*******USER root
#*******
#*******###### password of main user is Docker!
#*******###### REF: https://stackoverflow.com/questions/28721699/root-password-inside-a-docker-container
#*******RUN echo "main:Docker!" | chpasswd
#*******
#*******USER main
#*******WORKDIR /home/main
#*******#CMD ["export", "LD_LIBRARY_PATH", "=", "/home/main/pylibs/flint2:/home/main/pylibs/arb:/home/main/pylibs/flint2:/home/main/pylibs/arb:"]
#*******#####
#*******ADD flint_test.ipynb  /home/main/flint_test.ipynb
#*******
#*******
#*******####################
#*******###### A BETTER EXAMPLE TO CREATE MYBINDER INTERACTIVE NOTEBOOKS
#*******####################
#*******########  https://github.com/jupyterhub/binder/blob/master/doc/sample_repos.md
#*******####################

