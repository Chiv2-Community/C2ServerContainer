FROM steamcmd/steamcmd:ubuntu-22
ADD ./setup.sh /setup.sh

RUN apt-get update && \
    apt-get install -y python3.11 git wget

RUN git clone https://github.com/Chiv2-Community/C2ServerAPI.git /opt/C2ServerAPI

RUN mkdir /mods

ENTRYPOINT ["/bin/bash", "/setup.sh"]