#!/usr/bin/env bash

vol(){
	vol=`pamixer --get-volume-human`
	sleep 0
	echo -e "$vol"
}

clk(){
	clk="$(date +"%I:%M %p")"
	sleep 0
	echo -e " $clk"
}

dte(){
	dte="$(date +"%d %b, %A")"
	sleep 0
	echo -e " $dte"
}

mem(){
	mem=`free | awk '/Mem/ {printf "%d Mib", $3 / 1024.0, $2 / 1024.0 }'`
	sleep 0
	echo -e "$mem"
}

backlight(){
	backlight=`xbacklight -get`
	sleep 0
	echo -e " $backlight%"
}

cpu(){
	read cpu a b c previdle rest < /proc/stat
	prevtotal=$((a+b+c+previdle))
	sleep 0.5
	read cpu a b c idle rest < /proc/stat
	sleep 0.5
	total=$((a+b+c+idle))
	cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
	echo -e " $cpu%"
}

bat0(){
	read bate < /sys/class/power_supply/BAT0/capacity
	sleep 0
	if [ $bate = '100' ]; then
		notify-send Battery Full
		sleep 60
		break
	fi
	read status < /sys/class/power_supply/BAT0/status
	sleep 0
	if [ $status = 'Discharging' ]; then
		state=''	
	elif [ $status = 'Charging' ]; then
		state=''
	elif [ $status = 'Full' ]; then
		state='Full'
	fi
	bat0="$bate% $state"
	echo -e "$bat0"
}


while true; do
	xsetroot -name "$(cpu) | $(mem) | $(vol) | $(clk) | $(dte) | $(backlight) | $(bat0)"
	sleep 0
done
