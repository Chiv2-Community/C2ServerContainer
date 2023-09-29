FROM cm2network/steamcmd:root

RUN apt-get update && \
    apt-get install -y python3 git wget rsync tree curl

RUN git clone https://github.com/Chiv2-Community/C2ServerAPI.git /opt/C2ServerAPI


RUN mkdir /mods
RUN mkdir /config

ADD ./run.sh /run.sh

USER steam

ENTRYPOINT ["/bin/bash", "/run.sh"]