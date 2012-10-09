#!/bin/bash

# AmahiRip Uninstaller #########################################################
## This script uninstalls AmahiRip, the automatic CD/DVD ripper for Amahi.    ##
##                                                                            ##
## Original scripts by Adam Jenkins                                           ##
## Updated and packaged for Amahi by Steven Mirabito                          ##
################################################################################

#########################################################
# Get elevated privileges
#########################################################

mkdir elevated
cd elevated
cat > elevated-uninstaller << 'ENDDUMP'

#########################################################
# Remove files
#########################################################

echo "*** Removing files..."
cd ..
rm -rf $(ls | grep -vx elevated)

#########################################################
# Remove cron jobs
#########################################################

echo "*** Removing cron jobs..."
cronTemp=${cronTemp:=/tmp/$(date +%m%d%H%M%S).cron}
crontab -l > $cronTemp
sed -i '/# AmahiRip/,/# End AmahiRip/d' $cronTemp
crontab $cronTemp
rm -f $cronTemp

#########################################################
# Remove udev rule
#########################################################

if [ -e /etc/udev/rules.d/99-amahirip.rules ]
then
   rm -f /etc/udev/rules.d/99-amahirip.rules
fi

service udev restart

ENDDUMP

chmod +x elevated-uninstaller
sudo ./elevated-uninstaller

#########################################################
# Clean up
#########################################################

echo "*** Cleaning up..."
cd ..
rm -rf elevated

#########################################################
# Done!
#########################################################

echo "*** Uninstallation complete!"