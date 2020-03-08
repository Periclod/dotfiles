#!/bin/bash

killall picom
picom -i 0.95 -f --blur-background-frame --blur-background-fixed --use-damage -I 0.056 -O 0.06 -b -d :0

