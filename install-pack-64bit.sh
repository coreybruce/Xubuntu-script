#Xubuntu 16.04 64bit install pack 2.8

sudo apt-get update

#Dockbarx

sudo add-apt-repository ppa:dockbar-main/ppa
sudo apt-get update
sudo apt-get install --install-recommends xfce4-dockbarx-plugin dockbarx-themes-extra

#ARC theme

cd /tmp
sudo apt install autoconf automake pkg-config libgtk-3-dev git
git clone https://github.com/horst3180/arc-theme
cd arc-theme
./autogen.sh --prefix=/usr
sudo make install
sudo apt-get remove --auto-remove ubuntu-gnome-desktop gnome-shell
sudo apt autoremove


#Gnome tools & other tools

sudo apt-get install gnome-screensaver gnome-system-monitor gnome-terminal gnome-disk-utility exfat-fuse exfat-utils shotwell git preload gdebi synaptic gnome-mpv seahorse fonts-roboto

#Flat Remix icon Theme

cd /tmp
git clone https://github.com/daniruiz/Flat-Remix
sudo mv "flat-remix/Flat-Remix" /usr/share/icons/
sudo mv "flat-remix/Flat-Remix-Dark" /usr/share/icons/
sudo mv "flat-remix/Flat-Remix-Light" /usr/share/icons/
sudo mv "flat-remix/Flat-Remix-Dark" /usr/share/icons/

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
tar xf bluez-*.tar.xz
cd bluez-*
./configure --prefix=/usr --mandir=/usr/share/man
make && sudo make install

#Compton
sudo apt install cmake asciidoc libglu1-mesa-dev freeglut3-dev mesa-common-dev libconfig-dev libxrender-dev libx11-dev libxrandr-dev libxinerama-dev libdbus-1-dev libpcre3-dev
cd /tmp
git clone https://github.com/chjj/compton
cd compton
sudo make docs
sudo make install
sudo apt autoremove

#Setting Configs
tar -xvzf xfpanel-switch.tar.gz
tar -xvzf xfce-config.tar.gz
tar -xvzf Wallpapers.tar.gz
tar -xvzf sys-icons.tar.gz
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
xfconf-query -c xsettings -p /Net/ThemeName -s "Arc"
xfconf-query -c xfwm4 -p /general/theme -s Windows-10


#removing Libre office and Amazon

sudo apt-get remove --purge libreoffice*
sudo apt-get clean
sudo apt-get autoremove
sudo apt-get remove --purge libreoffice* ristretto pidgin parole light-locker
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
