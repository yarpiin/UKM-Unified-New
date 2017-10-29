#!/system/bin/sh

UKM=/data/UKM;
BB=$UKM/busybox;

#Official

		CONFIG="unified";

if [ -n "$CONFIG" ]; then PATH="$UKM/device/$CONFIG.sh"; else PATH=""; fi;

$BB echo "$PATH";
