#!/usr/bin/env bash
# to be run as sudo
oldDomain="xavier.ibuildings.uk" # Enter the FQDN of your old OD
# These variables probably don't need to be changed
check4OD=`dscl localhost -list /LDAPv3 | grep $oldDomain`
# Check if bound to old Open Directory domain
if [ "${check4OD}" == "${oldDomain}" ]; then
	echo "This machine is joined to ${oldDomain}"
	echo "Removing from ${oldDomain}"
	dsconfigldap -r "${oldDomain}"
	dscl /Search -delete / CSPSearchPath /LDAPv3/"${oldDomain}"
	dscl /Search/Contacts -delete / CSPSearchPath /LDAPv3/"${oldDomain}"
	if [ "${odSearchPath}" = "" ]; then
		echo "$oldDomain not found in search path."
	fi
fi
killall DirectoryService
echo "Finished. Exiting..."
exit 0
