#!/usr/bin/env bash
# to be run as sudo
oldDomain="$1" # Enter the FQDN of your old OD
newDomain="$2" # Enter the FQDN of your new OD
# These variables probably don't need to be changed

echo "Removing from ${oldDomain}"
dsconfigldap -r "${oldDomain}"
dscl /Search -delete / CSPSearchPath "/LDAPv3/${oldDomain}"
dscl /Search/Contacts -delete / CSPSearchPath "/LDAPv3/${oldDomain}"
echo "Connecting to ${oldDomain}"
ipconfig set en0 DHCP
ipconfig set en1 DHCP
ipconfig set en2 DHCP
dsconfigldap -Na "${newDomain}"

killall DirectoryService
echo "Finished. Welcome to ${newDomain}"
exit 0
