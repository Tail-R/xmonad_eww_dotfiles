#!/bin/bash

STATUS=`brightnessctl | grep Current | awk '{print $3}'`
TRUEVARUE=$(($STATUS/12*10))

echo "${TRUEVARUE}"
