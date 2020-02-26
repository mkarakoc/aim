# link of the Docker container
# https://hub.docker.com/r/hesap/
FROM hesap/aimpy:main202002270048

MAINTAINER Mesut Karakoç <mesudkarakoc@gmail.com>

# becom root to change main password
USER root

ADD examples    /home/main/examples
RUN chown -R main:main /home/main/examples

# main user name somehow chosen by someone that i do not know, yet. kind of forced to use!
# REF: https://mybinder.readthedocs.io/en/latest/dockerfile.html#preparing-your-dockerfile
USER main

# create flint and arb path for the container when it used by mybinder.org
# some how mybinder.org does not see .bashrc or .profile files
#ENV LD_LIBRARY_PATH "${LD_LIBRARY_PATH}:/home/main/pylibs/flint2:/home/main/pylibs/arb"

# force the container to use bash
# REF: https://stackoverflow.com/questions/33467098/how-can-the-terminal-in-jupyter-automatically-run-bash-instead-of-sh
#ENV SHELL "/bin/bash"
#ENV LANG en_US.UTF-8

# working directory
WORKDIR /home/main

