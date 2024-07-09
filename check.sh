#!/bin/bash

while :
do
     echo "running"
     if [ -f /home/runner/end.txt ] 
     then
          break
     fi
     sleep 3
     clear
done
