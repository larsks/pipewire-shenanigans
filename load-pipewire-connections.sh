#!/bin/bash

message="Connecting"
action=pw-link

while getopts d ch; do
	case $ch in
		d)
			message="Disconnecting"
			action="pw-link -d"
			;;
	esac
done
shift $((OPTIND-1))

grep -Ev '^$|^#' connections.tab | while read -r left right; do
	echo "$message $left -> $right"
	$action "$left" "$right"
done
