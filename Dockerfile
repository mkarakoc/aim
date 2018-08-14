#FROM hesap/jupyter
FROM hesap/aimpy:jovyan
#FROM hesap/aim_trials:latest

MAINTAINER Mesut Karakoç <mesudkarakoc@gmail.com>

#ENV NB_USER jovyan
#ENV NB_UID 1000

#One or more build-args [NB_USER NB_UID] were not consumed
ARG NB_USER = jovyan
ARG NB_UID = 1000
ENV HOME /home/${NB_USER}

USER root
RUN chown -R ${NB_UID} ${HOME}

USER ${NB_USER}

WORKDIR /home/${NB_USER}

CMD ["jupyter", "notebook", "--ip", "0.0.0.0"]
