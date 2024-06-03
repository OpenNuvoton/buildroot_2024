#!/bin/sh

echo 'ENV{LIBINPUT_CALIBRATION_MATRIX}="'$2 $3 $4 $5 $6 $7'"' > /etc/udev/rules.d/libinput.rules
