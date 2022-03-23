#!/usr/bin/env bash

xss-lock --transfer-sleep-lock -- i3lock -c 00000000 --nofork &
dunst &
picom --experimental-backends -b &
