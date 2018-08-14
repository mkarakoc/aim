#FROM hesap/jupyter
FROM hesap/aimpy:main
#FROM hesap/aim_trials:latest

MAINTAINER Mesut Karakoç <mesudkarakoc@gmail.com>

#One or more build-args [NB_USER NB_UID] were not consumed
ARG NB_USER=main
ARG NB_UID=1000
ENV HOME /home/${NB_USER}

USER root
RUN chown -R ${NB_UID} ${HOME}

USER ${NB_USER}

WORKDIR /home/${NB_USER}
