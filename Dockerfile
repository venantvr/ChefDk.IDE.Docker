FROM lalyos/ubuntu-desktop
MAINTAINER venantvr

##########################################
# Installation du bureau
##########################################
RUN apt-get update
RUN apt-get -y install apt-utils
RUN apt-get -y install nano
RUN apt-get -y install wget

##########################################
# Installation de chefdk
##########################################
RUN wget https://packages.chef.io/files/stable/chefdk/1.1.16/ubuntu/16.04/chefdk_1.1.16-1_amd64.deb
RUN dpkg -i chefdk_1.1.16-1_amd64.deb
RUN ls -alrtd /opt/chefdk

##########################################
# Installation de ruby
##########################################
RUN apt-get -y install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs
RUN apt-get -y install ruby-full
RUN ruby -v
RUN gem install bundler

##########################################
# Installation de git
##########################################
RUN apt-get -y install git
RUN git config --global user.email "r.venant.valery@gmail.com"
RUN git config --global user.name "venantvr"

##########################################
# Installation de gedit & xfe & firefox & tree
##########################################
RUN apt-get -y install gedit
RUN apt-get -y install xfe
RUN apt-get -y install firefox
RUN apt-get -y install tree

##########################################
# Installation de visual studio code
##########################################
RUN apt-get -y -f install
RUN wget https://az764295.vo.msecnd.net/stable/ee428b0eead68bf0fb99ab5fdc4439be227b6281/code_1.8.1-1482158209_amd64.deb
RUN dpkg -i code_1.8.1-1482158209_amd64.deb

# Source : http://stackoverflow.com/questions/33984906/cant-launch-visual-studio-code-on-ubuntu
RUN sudo sed -i 's/BIG-REQUESTS/_IG-REQUESTS/' /usr/lib/x86_64-linux-gnu/libxcb.so.1

##########################################
# Finalisation
##########################################
RUN rm -f /tmp/.X1-lock && rm -f /tmp/.X11-unix/X1

# Set user for VNC server
# Set default password
# Copy VNC script that handles restarts
ENV USER root
COPY password.txt .
RUN cat password.txt password.txt | vncpasswd && rm password.txt
COPY start-vnc.sh /opt/
RUN chmod +x /opt/start-vnc.sh
CMD [ "/bin/sh", "/opt/start-vnc.sh" ]

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y clean

EXPOSE 5901

