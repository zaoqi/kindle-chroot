#!/bin/sh
cd "$(dirname "$0")" || exit
/mnt/us/extensions/kterm/bin/kterm.sh -e "$PWD"'/run-distribution.sh alpine.3.9.0.armhf.sh'
