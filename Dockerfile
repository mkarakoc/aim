#FROM hesap/jupyter
FROM hesap/aimpy:joyvan
#FROM hesap/aim_trials:latest

MAINTAINER Mesut Karakoç <mesudkarakoc@gmail.com>

ENV NB_USER jovyan
ENV NB_UID 1000
ENV HOME /home/${NB_USER}

USER ${NB_USER}
