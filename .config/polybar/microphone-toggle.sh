#!/bin/bash

default_source="$(pactl info @DEFAULT_SOURCE@ | awk '/Default Source:/{print $3}')"
state="$(pactl list sources | awk '/Name: '"$default_source"'/{x=1}/Mute:/&&x==1{print $2;x=0}')"

if [ "$state" = "no" ]
then
    #echo "" # on
    echo "󰍬"
else
    #echo "" # muted
    echo "󰍭"
fi
