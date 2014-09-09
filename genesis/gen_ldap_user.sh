#!/bin/bash
LDAP_SERVER=$1
SUDO_USER=$2
BASE=$3
LDAP_ADMIN=$4
LDAP_ADMIN_PWD=$5
USER_DEPARTMENT=$6

URI="ldap://$LDAP_SERVER"
OU="ou=employees,$BASE"
BINDDN="cn=$LDAP_ADMIN,$BASE"
BINDPW="$LDAP_ADMIN_PWD"

# identify the next UIDNUMBER available
ssh $SUDO_USER@$LDAP_SERVER ldapsearch $OPTIONS -H ${URI} -w ${BINDPW} -D ${BINDDN} \
    -b ${OU} \
    '(&(objectClass='inetOrgPerson'))' \
    'uid' \
    | sed -n '/^ /{H;d};s/uidNumber: //gp;s/^0*//' \
    | sort -n \
    | tail -1

# Create the LDIF file

# load the LDIF file creating the account

