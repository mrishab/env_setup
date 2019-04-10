#!/bin/bash

# THIS SCRIPT NEEDS TO BE RUN WITH -E flag and ROOT PRIVILEDGES

# Constants

## User Details

NAME=""
EMAIL=""

## Installation Path
INSTALLATION_PATH="/opt"

## Download URLS
VS_CODE_URL="https://az764295.vo.msecnd.net/stable/a3db5be9b5c6ba46bb7555ec5d60178ecc2eaae4/code_1.32.3-1552606978_amd64.deb"
GOOGLE_CHROME_URL="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
ANDROID_STUDIO="https://dl.google.com/dl/android/studio/ide-zips/3.3.2.0/android-studio-ide-182.5314842-linux.zip"
ECLIPSE="http://eclipse.mirror.rafal.ca/technology/epp/downloads/release/2019-03/R/eclipse-jee-2019-03-R-linux-gtk-x86_64.tar.gz"
INTELLIJ_IDEA="https://download.jetbrains.com/idea/ideaIC-2018.3.5.tar.gz"
JDK="https://download.oracle.com/otn-pub/java/jdk/11.0.2+9/f51449fcd52f4d52b93a989c5c56ed3c/jdk-11.0.2_linux-x64_bin.deb"
PYTHON="https://www.python.org/ftp/python/3.7.2/Python-3.7.2.tar.xz"
PYCHARM="https://download.jetbrains.com/python/pycharm-community-2018.3.5.tar.gz"
FILEZILLA="https://dl3.cdn.filezilla-project.org/client/FileZilla_3.41.2_x86_64-linux-gnu.tar.bz2"
LASTPASS="https://download.cloud.lastpass.com/linux/lplinux.tar.bz2"
MAVEN="http://apache.mirror.gtcomm.net/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz"
TOMCAT="http://apache.mirror.vexxhost.com/tomcat/tomcat-8/v8.5.39/bin/apache-tomcat-8.5.39.tar.gz"
NODEJS="https://nodejs.org/dist/v10.15.3/node-v10.15.3-linux-x64.tar.xz"
VIRTUAL_BOX="https://download.virtualbox.org/virtualbox/6.0.4/virtualbox-6.0_6.0.4-128413~Ubuntu~bionic_amd64.deb"

## Download Configurations
JDK_HEADER="Cookie: oraclelicense=accept-securebackup-cookie"

# Prereq Checks

if [ -z "$NAME" ]
then
    echo "You forgot to set the value of the Name variable. Please set your Name in the script before running";
    exit 1
elif [ -z $EMAIL ]
then
    echo "You forgot to set the value of the Email variable. Please set your Email in the script before running";
    exit 1
fi

# Changing the Directory to Downloads
cd Downloads

# Downloading the Applications 
wget $VS_CODE_URL
wget $GOOGLE_CHROME_URL
wget $ANDROID_STUDIO
wget $ECLIPSE -o $ECLIPSE_NAME
wget $PYTHON
wget $PYCHARM
wget $INTELLIJ_IDEA
wget $LASTPASS
wget $FILEZILLA -o $FILEZILLA_NAME
wget $NODEJS
wget $VIRTUAL_BOX
wget $MAVEN
wget $TOMCAT
wget --no-check-certificate  --header $JDK_HEADER $JDK

# ================> Checked

# Base OS Update
apt update -y
apt upgrade -y

# Installation

## Android Studio
unzip android-studio-ide-182.5314842-linux.zip
mv android-studio $INSTALLATION_PATH/

## Visual Studio Code
apt install -f ./code_1.32.3-1552606978_amd64.deb

## Google Chrome
apt install -f ./google-chrome-stable_current_amd64.deb -y

## Eclipse
tar xf eclipse-jee-2019-03-R-linux-gtk-x86_64.tar.gz
mv eclipse/ $INSTALLATION_PATH/

## IntelliJ Idea
tar xf ideaIC-2018.3.5.tar.gz
mv idea-IC-183.5912.21/ $INSTALLATION_PATH/

## JDK
apt install -f ./jdk-11.0.2_linux-x64_bin.deb -y
### Installation Location: /usr/lib/jvm/jdk-11.0.2

## Python
tar xf Python-3.7.2.tar.xz

## PyCharm
tar xf pycharm-community-2018.3.5.tar.gz

## FileZilla

## LastPass
mkdir lastpass
mv lplinux.tar.bz2 lastpass/
cd lastpass
tar xjf ./lplinux.tar.bz2
cd ..
mv lastpass $INSTALLATION_PATH/

## Maven
tar xf apache-maven-3.6.0-bin.tar.gz
mv apache-maven-3.6.0 $INSTALLATION_PATH/

## Tomcat
tar xf apache-tomcat-8.5.39.tar.gz
mv apache-tomcat-8.5.39 $INSTALLATION_PATH/

## NodeJS
tar xf node-v10.15.3-linux-x64.tar.xz

## Virtual Box
apt install -f ./virtualbox-6.0_6.0.4-128413~Ubuntu~bionic_amd64.deb -y

## Curl
apt install curl -y

## Git
apt install git -y

## VLC Media Player
apt install snap -y
snap install vlc

## LAMP
apt install apache2 -y
apt install mysql-server -y
apt install php libapache2-mod-php php-mysql -y

## Docker
apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" -y
apt update -y
apt install docker-ce docker-ce-cli containerd.io -y
groupadd docker
usermod -aG docker $USER

## Postgres DB
deb http://apt.postgresql.org/pub/repos/apt/ YOUR_DEBIAN_VERSION_HERE-pgdg main
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt add -
apt update -y
apt install postgresql-10 -y


# Setting up Environment
cd ~
## Backing up the original /etc/profile
cp /etc/profile /etc/profile.backup

## JDK
echo "export JAVA_HOME=\"/usr/lib/jvm/jdk-11.0.2\"" >> /etc/profile
## Android Studio
echo "export ANDROID_STUDIO=\"$INSTALLATION_PATH/android-studio\"" >> /etc/profile
## IntelliJ Idea
echo "export INTELLIJ_IDEA=\"$INSTALLATION_PATH/idea-IC-183.5912.21\"" >> /etc/profile
## Pycharm Community
echo "export PYCHARM=\"$INSTALLATION_PATH/pycharm-community-2018.3.5\"" >> /etc/profile
## NodeJS
echo "export NODEJS=\"$INSTALLATION_PATH/node-v10.15.3-linux-x64\"" >> /etc/profile
## Eclipse
echo "export ECLIPSE_HOME=\"$INSTALLATION_PATH/eclipse\"" >> /etc/profile
## Maven
echo "export MAVEN_HOME=\"$INSTALLATION_PATH/apache-maven-3.6.0\"" >> /etc/profile
## Tomcat
echo "export TOMCAT_HOME=\"$INSTALLATION_PATH/apache-tomcat-8.5.39\"" >> /etc/profile

## Setting the Path
echo 'export PATH=$PATH:$JAVA_HOME/bin:$ANDROID_STUDIO/bin:$INTELLIJ_IDEA/bin:$NODEJS/bin:$ECLIPSE_HOME:$MAVEN_HOME/bin:$TOMCAT_HOME/bin' >> /etc/profile

## Postgress
echo "export PGHOST=\"localhost\"" >> /etc/profile
echo "export PGPORT=\"5432\"" >> /etc/profile
echo "export PGUSER=\"postgres\"" >> /etc/profile

## Git
git config --global user.email "$EMAIL"
git config --global user.name "$NAME"

### Setting up the SSH Key
ssh-keygen -t rsa -b 4096 -C "$EMAIL" -N "" -f ~/.ssh/id_rsa
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

# Creating Shortcut Icons
## Reading the variables to the Environment
source /etc/profile
cd /usr/share/applications/

## Android Studio
touch android-studio.desktop
chmod +x android-studio.desktop
echo "[Desktop Entry]
Name=Android Studio
Version=1.0
Comment=Android Studio.
GenericName=IDE
Exec=$ANDROID_STUDIO/bin/studio.sh
Icon=$ANDROID_STUDIO/bin/studio.png
Type=Application
Categories=Utility;Development;IDE;
Keywords=android;studio;
Terminal=false" > android-studio.desktop

## Eclipse
touch eclipse.desktop
chmod +x eclipse.desktop
echo "[Desktop Entry]
Name=Eclipse Studio
Comment=Eclipse IDE.
GenericName=IDE
Exec=$ECLIPSE_HOME/eclipse
Icon=$ECLIPSE_HOME/icon.xpm
Type=Application
Categories=Utility;Development;IDE;
Keywords=eclipse;java;
Terminal=false" > eclipse.desktop

## IntelliJ Idea
touch intellij-idea.desktop
chmod +x intellij-idea.desktop
echo "[Desktop Entry]
Name=IntelliJ Idea
Comment=IntelliJ IDE Community.
GenericName=IDE
Exec=$INTELLIJ_IDEA/bin/idea.sh
Icon=$INTELLIJ_IDEA/bin/idea.png
Type=Application
Categories=Utility;Development;IDE;
Keywords=intellij;java;idea;
Terminal=false" > intellij-idea.desktop

## Pycharm
touch pycharm-community.desktop
chmod +x pycharm-community.desktop
echo "[Desktop Entry]
Name=Pycharm
Comment=Pycharm Community.
GenericName=IDE
Exec=$PYCHARM/bin/pycharm.sh
Icon=$PYCHARM/bin/pycharm.png
Type=Application
Categories=Utility;Development;IDE;
Keywords=python;pycharm;java;
Terminal=false" > pycharm-community.desktop

# End
cd ~