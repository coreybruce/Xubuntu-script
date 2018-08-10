#Xubuntu 18.04 64bit install pack 1.0.0

sudo apt-get update

#Dockbarx

sudo add-apt-repository ppa:xuzhen666/dockbarx
sudo apt-get update
sudo apt-get install xfce4-dockbarx-plugin dockbarx-themes-extra

#replaced Arc with Adapta as it's no longer maintained
#Adapta theme

sudo add-apt-repository ppa:tista/adapta
sudo apt update
sudo apt install adapta-gtk-theme


#Gnome tools & other tools

sudo apt-get install gnome-system-monitor gnome-terminal gnome-disk-utility exfat-fuse exfat-utils shotwell git preload gdebi synaptic gnome-mpv seahorse fonts-roboto file-roller

#Flat Remix icon Theme

cd /tmp
git clone https://github.com/daniruiz/Flat-Remix
sudo mv "Flat-Remix/Flat-Remix" /usr/share/icons/
sudo mv "Flat-Remix/Flat-Remix-Dark" /usr/share/icons/
sudo mv "Flat-Remix/Flat-Remix-Light" /usr/share/icons/
sudo mv "Flat-Remix/Flat-Remix-Dark" /usr/share/icons/

#Windows 10 theme (literally only using the window manager theme but you can use it if you want)
cd /tmp
git clone https://github.com/B00merang-Project/Windows-10
#Here is a dark version for you.
git clone https://github.com/B00merang-Project/Windows-10-Dark
sudo cp -r Windows-10* /usr/share/themes

#Splice Theme Dockbar

cd /tmp
git clone https://github.com/phenomenos/Splice
sudo mv "Splice/Splice.tar.gz" /usr/share/dockbarx/themes/

#Bluetooth BlueZ update/fix (feel free to do the same for newer versions if you want)
cd /tmp
sudo apt install libudev-dev libreadline-dev libical-dev
wget https://mirrors.edge.kernel.org/pub/linux/bluetooth/bluez-5.9.tar.xz
tar xf bluez-5.9.tar.xz
cd bluez-*
./configure --prefix=/usr --mandir=/usr/share/man
make && sudo make install

#Compton (experimental) is disabled until performance issues are fixed, will rely on default xfwm4 compositor instead which works fine
#sudo apt install cmake asciidoc libglu1-mesa-dev freeglut3-dev mesa-common-dev libconfig-dev libxrender-dev libx11-dev libxrandr-dev libxinerama-dev libdbus-1-dev libpcre3-dev
#cd /tmp
#git clone https://github.com/chjj/compton
#cd compton
#sudo make docs
#sudo make install
#sudo apt autoremove

#Downloading config files
wget https://github.com/coreybruce/Xubuntu-setup-script/raw/master/Xubuntu-18.04/sys-icons.tar.gz
wget https://github.com/coreybruce/Xubuntu-setup-script/raw/master/Xubuntu-18.04/wallpapers.tar.gz
wget https://github.com/coreybruce/Xubuntu-setup-script/raw/master/Xubuntu-18.04/whiskermenu-1.rc
wget https://github.com/coreybruce/Xubuntu-setup-script/raw/master/Xubuntu-18.04/xfce-config.tar.gz
wget https://github.com/coreybruce/Xubuntu-setup-script/raw/master/Xubuntu-18.04/xfpanel-switch.tar.gz

#Setting Configs
tar -xvzf xfpanel-switch.tar.gz
tar -xvzf xfce-config.tar.gz
tar -xvzf Wallpapers.tar.gz
tar -xvzf sys-icons.tar.gz

#Moving config files
mkdir -p ~/.local/share
mkdir -p ~/.local/share/applications
mkdir -p ~/.config/autostart/
cp -r compton.desktop ~/.config/autostart/
cp -r xfpanel-switch ~/.local/share
mkdir -p ~/.config
cp -r xfce4 ~/.config/
cp -r compton.conf ~/.config
cp -r Wallpapers /home/$USER/Pictures/
sudo cp -r sys-icons /usr/share/
cp -r whiskermenu-1.rc ~/.config/xfce4/panel/

echo "Setting up looks"
python3 /usr/share/xfpanel-switch/xfpanel-switch/panelconfig.py load /home/$USER/.local/share/xfpanel-switch/Xubuntu-Custom.tar.bz2
xfconf-query -c xsettings -p /Net/IconThemeName -s "Flat-Remix"
xfconf-query -c xsettings -p /Net/ThemeName -s "Adapta"
xfconf-query -c xfwm4 -p /general/theme -s Windows-10


#removing Libre office and Amazon

sudo apt-get remove --purge libreoffice*
sudo apt-get clean
sudo apt-get autoremove
sudo apt-get remove --purge libreoffice* ristretto pidgin parole engrampa engrampa-common
sudo apt-get clean
sudo apt-get autoremove
sudo preload

#updating system
sudo apt dist-upgrade

#cleanup
sudo apt autoremove

echo Your installations are finished.

echo restarting in 3 seconds to take full effect...
sleep 3
sudo reboot now
