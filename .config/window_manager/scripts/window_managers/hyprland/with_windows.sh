#!/bin/bash
if [[ $(hyprctl workspaces -j | jq '.[].id' | grep $1) ]]
then 
   echo yes
else 
   echo no
fi

