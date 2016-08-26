FROM ubuntu:16.04
MAINTAINER Hao Xu <xuh@email.unc.edu>
# install stack
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 575159689BEFB442
RUN echo 'deb http://download.fpcomplete.com/ubuntu xenial main' | tee /etc/apt/sources.list.d/fpco.list
RUN apt-get update && apt-get install stack -y
# install libs
RUN apt-get install libsqlite3 postgresql-server-dev-all
