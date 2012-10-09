#!/bin/bash

# AmahiRip Installer ###########################################################
## This script installs AmahiRip, the automatic CD/DVD ripper for Amahi.      ##
##                                                                            ##
## Original scripts by Adam Jenkins                                           ##
## Updated and packaged for Amahi by Steven Mirabito                          ##
################################################################################

#########################################################
# Get elevated privileges
#########################################################

mkdir elevated
cd elevated
echo 'export HDA_APP_DIR='$HDA_APP_DIR > elevated-installer
cat >> elevated-installer << 'ENDDUMP'

#########################################################
# Install OS-specific dependencies
#  --> libdvdcss on Ubuntu
#  --> handbrake-cli, vobcopy, and libdvdcss on Fedora
#########################################################

if [ -f /etc/debian_version ]
then
	echo "*** Installing libdvdcss..."
	sudo /usr/share/doc/libdvdread4/install-css.sh
fi

# TODO: Add code to build dependencies for Fedora

#########################################################
# Download and install files
#########################################################

echo "*** Installing files..."
amahi-download http://dl.dropbox.com/u/1226885/amahi/amahirip-0.2a.tar.bz2 5553a2653004ef1972d2d666ba122cd1e84dbf2a
tar -jxf amahirip-0.2a.tar.bz2
cd amahirip-0.2a
mv * ../../
chmod +x ../../scripts/*

#########################################################
# Download and install RubyRipper
#########################################################

echo "*** Installing RubyRipper..."
wget http://rubyripper.googlecode.com/files/rubyripper-0.6.2.tar.bz2
tar -xvf rubyripper-0.6.2.tar.bz2

cd rubyripper-0.6.2

./configure --enable-cli --ruby=/lib/ruby --prefix=$HDA_APP_DIR

make install

cd ..

rm -rf rubyripper*

#########################################################
# Fix paths
#########################################################

if [ ! -e /usr/bin/normalize ] 
then
   ln -s /usr/bin/normalize-audio /usr/bin/normalize
fi

#########################################################
# Create cache directory for RubyRipper
#########################################################

echo "*** Creating directories..."
mkdir -p $HDA_APP_DIR/.cache

#########################################################
# Add udev rule
#########################################################

echo "*** Adding udev rule..."
if [ ! -e /etc/udev/rules.d/99-amahirip.rules ]
then
   rm -f /etc/udev/rules.d/99-amahirip.rules
fi

echo 'SUBSYSTEM=="block", KERNEL=="sr0", RUN+="'$HDA_APP_DIR'/scripts/udev_bootstrap", OPTIONS="last_rule"' > /etc/udev/rules.d/99-amahirip.rules

service udev restart

#########################################################
# Add necessary cron jobs
#########################################################

echo "*** Installing cron jobs..."
cronTemp=${cronTemp:=/tmp/$(date +%m%d%H%M%S).cron}
crontab -l > $cronTemp
echo '# AmahiRip' >> $cronTemp
echo '*/5 22,23,0-14 * * 2-5 PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin '$HDA_APP_DIR'/scripts/Qmanager' >> $cronTemp
echo '*/5 23,0,1,2,3,4,5,6 * * 0,1,6 PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin '$HDA_APP_DIR'/scripts/Qmanager' >> $cronTemp
echo '# End AmahiRip' >> $cronTemp
crontab $cronTemp
rm -f $cronTemp

#########################################################
# Fix permissions
#########################################################

chown -R www-data:users $HDA_APP_DIR/*
chown -R www-data:users $HDA_APP_DIR/.[^.]*

#########################################################
# Replace %AMAHIRIP_DIR% with real directory
#########################################################

echo "*** Replacing variables in files..."
grep -rl '%AMAHIRIP_DIR%' $HDA_APP_DIR | xargs perl -i -pe 's|\%AMAHIRIP_DIR\%|$ENV{HDA_APP_DIR}|g'

ENDDUMP

chmod +x elevated-installer
sudo ./elevated-installer

#########################################################
# Clean up
#########################################################

echo "*** Cleaning up..."
cd ..
rm -rf elevated

#########################################################
# Done!
#########################################################

echo "*** Installation complete!"