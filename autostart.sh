#!/usr/bin/env bash

xss-lock --transfer-sleep-lock -- blurlock --nofork &
dunst &
picom --experimental-backends -b &
