sudo docker pull lalyos/ubuntu-desktop
sudo docker run -it --rm -p 5901:5901 -e USER=root lalyos/ubuntu-desktop \
    bash -c "vncserver :1 -geometry 1280x800 -depth 24 && tail -F /root/.vnc/*.log"
remmina -c ./ubuntu-desktop.remmina
sudo docker run -it --rm -p 5901:5901 -e USER=root venantvr/ubuntu-vm \
    bash -c "rm -f /tmp/.X1-lock && rm -f /tmp/.X11-unix/X1 && vncserver :1 -geometry 1280x800 -depth 24 && tail -F /root/.vnc/*.log"

sudo dockebuild -t venantvr/ubuntu-chefdk:v1 .1 
sudo dockerun -it --rm -p 5901:5901 -e USER=root venantvr/ubuntu-chefdk:v1 
sudo docker ps -a -q | xargs -n 1 -I {} sudo docker rm {}
sudo docker images -q | xargs -n 1 -I {} sudo docker rmi -f {}


