#!/bin/bash 

## KERNEL
kern() {
	kern="$(uname -r)"
	echo -e $kern
}

## DATE
dte() {
	dte="$(date +"%a, %b %d %l:%M%p")"
	echo -e $dte
}

## RAM
mem() {
	mem="$(free | awk '/Mem/ {printf "%d MB/%d MB\n", $3 / 1024.0, $2 / 1024.0 }')"
	echo -e $mem
}

## VOLUME
vol() {
	#vol=`amixer get Master | awk -F'[][]' 'END{ print $4":"$2 }'`
	vol="$(amixer get Master | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/')"
	echo -e "${vol}%"
}

## CREATE THE BAR OUTPUT
## LOOPS WEATHER AND PACMAN UPDATES EVERY 25MINS, EVERYTHING ELSE EVERY 3 SECONDS
I=0
SLEEP_SEC=3
while :; do
	if [ $I -eq 0 ]; then
		PACUPDATE=$(checkupdates | wc -l)
		WEATHER=$(curl -s 'wttr.in/Gainesville?format=1&u' | sed 's/ //g' | sed 's/+//g')
		WTEXT=$(grep -o "[0-9].*" <<< "$WEATHER")
		WICON=${WEATHER:0:1}
	fi
	echo -e "+@fg=6;+@fn=1;$WICON+@fn=0; $WTEXT +@fg=0;| +@fg=1;+@fn=1;🔁+@fn=0; Updates: +@fg=4;$PACUPDATE+@fg=1; [$(kern)] +@fg=0;| +@fg=2;+@fn=1;💾+@fn=0; $(mem) +@fg=0;|+@fg=4; +@fn=1;🔊+@fn=0; $(vol) +@fg=0;| +@fg=5;+@fn=1;🗓+@fn=0; $(dte)"
	I=$(( ( ${I} + 1 ) % 500 ))
	sleep $SLEEP_SEC
done
