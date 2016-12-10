## Dockerfile for JSoftware ijconsole
## Mac Radigan

  FROM ubuntu:latest

  MAINTAINER Mac Radigan <mac@radigan.org>

  LABEL license="GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007"
  LABEL source="http://jsoftware.com/source.htm"

  RUN ulimit -n 1024
  RUN apt-get update && apt-get install -y curl
  RUN ulimit -n 1024
  RUN apt-get update && apt-get install -y wget

  RUN mkdir -p /usr/share/applications/
  RUN mkdir -p /usr/share/icons/hicolor/scalable/apps/

  ## JSoftware
  RUN ulimit -n 1024
  RUN apt-get update &&  \
      apt-get install -y \
        wget             \
        curl             \
        evince           \
        gnuplot


  RUN curl -o /tmp/j805_amd64.deb http://www.jsoftware.com/download/j805/install/j805_amd64.deb
  RUN dpkg -i /tmp/j805_amd64.deb
  RUN rm -f /tmp/j805_amd64.deb
  RUN ln -fs /usr/lib/x86_64-linux-gnu/libj.so.8.05 /usr/lib/x86_64-linux-gnu/libj.so

  ENV LD_LIBRARY_PATH /usr/lib/x86_64-linux-gnu/:$LD_LIBRARY_PATH
  RUN echo "load 'pacman'" >> /tmp/script.ij
  RUN echo "'update' jpkg ''" >> /tmp/script.ij
  RUN echo "'install' jpkg 'base library'" >> /tmp/script.ij
  RUN echo "'install' jpkg 'graphics/plot'" >> /tmp/script.ij
  RUN echo "'install' jpkg 'graphics/gnuplot'" >> /tmp/script.ij
  RUN echo "'install' jpkg 'tables/csv'" >> /tmp/script.ij
  RUN cat /tmp/script.ij | /usr/bin/ijconsole
  RUN rm -f /tmp/script.ij

  # ijconsole entry point
  ENTRYPOINT ["/usr/bin/ijconsole"]

## *EOF*
