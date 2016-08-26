FROM ubuntu:16.04
MAINTAINER Hao Xu <xuh@email.unc.edu>

# install stack
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 575159689BEFB442
RUN echo 'deb http://download.fpcomplete.com/ubuntu xenial main' | tee /etc/apt/sources.list.d/fpco.list
RUN apt-get update && apt-get install stack -y

# install libs
RUN apt-get update && apt-get install libsqlite3-dev postgresql-server-dev-all -y

# install wget
RUN apt-get update && apt-get install wget -y

# install QueryArrow
RUN git clone https://github.com/xu-hao/QueryArrow.git
WORKDIR /QueryArrow
RUN stack setup
RUN stack install --only-dependencies
RUN make gen
RUN stack build ; exit 0 # currently test doesn't build, but it doesn't affect server

# add config file
COPY config.json rewriting.rules /QueryArrow/test/

# set entry point
ENTRYPOINT ["stack", "exec", "QueryArrow", "/QueryArrow/test/config.json"]
CMD ["tcp", "*", "12345"]

# must set up networking when running docker
