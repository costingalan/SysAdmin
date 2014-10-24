#!/usr/bin/env bash
# to be run as sudo
oldDomain="$1" # Enter the FQDN of your old OD
newDomain="$2" # Enter the FQDN of your new OD
# These variables probably don't need to be changed
check4OD=`dscl localhost -list /LDAPv3 | grep $oldDomain`
# Check if bound to old Open Directory domain
if [ "${check4OD}" == "${oldDomain}" ]; then
	echo "This machine is joined to ${oldDomain}"
	echo "Removing from ${oldDomain}"
	dsconfigldap -r "${oldDomain}"
	dscl /Search -delete / CSPSearchPath "/LDAPv3/${oldDomain}"
	dscl /Search/Contacts -delete / CSPSearchPath "/LDAPv3/${oldDomain}"
fi
echo "Connecting to ${oldDomain}"
dsconfigldap -Na "${newDomain}"

killall DirectoryService
echo "Finished. Welcome to ${newDomain}"
exit 0
