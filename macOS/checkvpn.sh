#!/bin/sh
#
# checkvpn.sh Jon Gardner 01 Jan 2009
# Enhancements Peter Scordamaglia 19 Jan 2009
# From http://www.afp548.com/article.php?story=20090101135805857
#
# This script resets the VPN service to clear malware attack connections, but only if there
# are no valid user connections in progress.
#
# UPDATED 6/16/2016 
# by billcd
# changeds serveradmin command to a var since /usr/sbin is typically not writable in macOS El Capitan

SERVERADMIN='/Applications/Server.app/Contents/ServerRoot/usr/sbin/serveradmin'

echo "PPTP Current Start Time: \c" && $SERVERADMIN fullstatus vpn|grep startedTime|grep pptp|cut -f2 -d'='|sed -e"s/\"//g"
echo "L2TP Current Start Time: \c" && $SERVERADMIN fullstatus vpn|grep startedTime|grep l2tp|cut -f2 -d'='|sed -e"s/\"//g"
CONNP=`$SERVERADMIN fullstatus vpn|grep CurrentConnections|grep pptp|cut -f2 -d'='`
CONNL=`$SERVERADMIN fullstatus vpn|grep CurrentConnections|grep l2tp|cut -f2 -d'='`
CONN=`expr $CONNP + $CONNL`
echo "Active PPTP connections: $CONNP"
echo "Active L2TP connections: $CONNL"
echo " --"
echo "Active VPN connections: $CONN"
if [ "$CONN" -gt 0 ]
then
    USERS=`$SERVERADMIN command vpn:command = getConnectedUsers | grep name | cut -f2 -d'='|sed -e"s/\"//g"`
    if [ "" != "$USERS" ]
    then
        echo
        echo "-----Current Users-----"
        echo "Active VPN users: $USERS"
    fi
else
    echo "No authorized VPN users connected."
    echo Restarting VPN service...
    $SERVERADMIN stop vpn
    sleep 5
    $SERVERADMIN start vpn
    echo "PPTP New Start Time: \c" && $SERVERADMIN fullstatus vpn|grep startedTime|grep pptp|cut -f2 -d'='|sed -e"s/\"//g"
    echo "L2TP New Start Time: \c" && $SERVERADMIN fullstatus vpn|grep startedTime|grep l2tp|cut -f2 -d'='|sed -e"s/\"//g"
fi
