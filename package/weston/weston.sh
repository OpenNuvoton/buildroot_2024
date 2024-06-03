#!/bin/sh

if test -z "${XDG_RUNTIME_DIR}" ; then
	export XDG_RUNTIME_DIR=/tmp/xdg
	if ! test -d "${XDG_RUNTIME_DIR}" ; then
		mkdir -p "${XDG_RUNTIME_DIR}"
		chmod 0700 "${XDG_RUNTIME_DIR}"
	fi
fi

export MESA_LOADER_DRIVER_OVERRIDE=swrast
export LIBGL_ALWAYS_SOFTWARE=true

weston_pid=$(pidof weston)

if [[ -z "${weston_pid}" ]] ; then
	weston --tty=1 --config=/etc/xdg/weston/weston.ini &
fi

# weston 9.0.0, display_id=0
# weston 10.0.0, display_id=1
display_id=1

export WAYLAND_DISPLAY=wayland-${display_id}

# for capacitive touchscreen, USING_RESISTIVE_TOUCHSCREEN=0
# for resistive touchscreen, USING_RESISTIVE_TOUCHSCREEN=1
USING_RESISTIVE_TOUCHSCREEN=0

SYS=/sys
TSDEVICE=

for i in $(ls /dev/input/event*)
do
	DEVPATH=$(udevadm info --query=path --name=$i | grep 40420000.adc)
	if [[ ! -z "$DEVPATH" ]] ; then
		TSDEVICE=${SYS}${DEVPATH}
	fi
done

if [[ "$USING_RESISTIVE_TOUCHSCREEN" -eq 1 ]] ; then
	if ! test -f "/etc/udev/rules.d/libinput.rules" ; then
		sleep 1
		weston-touch-calibrator ${TSDEVICE}
	fi
fi
