FROM steamcmd/steamcmd:ubuntu-22

RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime

RUN apt-get update && \
    apt-get install -y python3 git wget rsync tree curl

RUN git clone https://github.com/Chiv2-Community/C2ServerAPI.git /opt/C2ServerAPI

RUN mkdir /mods
RUN mkdir /config

ADD ./run.sh /run.sh

ENTRYPOINT ["/bin/bash", "/run.sh"]