#!/bin/sh
cd "$(dirname "$0")" || exit
/mnt/extensions/kterm/bin/kterm.sh -e './run-distribution.sh alpine.3.9.0.armhf.sh'
