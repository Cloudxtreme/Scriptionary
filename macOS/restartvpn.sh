#!/bin/bash
#
# 6/16/2016 
# by billcd

SERVERADMIN='/Applications/Server.app/Contents/ServerRoot/usr/sbin/serveradmin'

$SERVERADMIN stop vpn
sleep 5
$SERVERADMIN start vpn


