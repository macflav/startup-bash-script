#!/bin/bash

if ! test -e /tmp/.X0-lock
then
	loop=1
	while [ $loop = 1 ]
	do
		dialog \
		--title 'Startup Options' \
		--colors          \
		--infobox '\n
		\Z1\Zr C \ZR\Z4ommand \Znor \Z1\Zr L \ZR\Z4inux\Zn to go straight to command line prompt;\n\n
		\Z1\Zr U \ZR\Z4pgrade \Znor \Z1\Zr P \ZR\Z4acman\Zn to perform full system upgrade; or\n\n
		Any other key to start Xfce4...' \
		9 65
		read -s -t 5 -n 1 answer
		echo
		case $answer in
		U|u|P|p)
			clear
			echo -e ":: Performing full system upgrade..."
			sudo pacman -Syu
			echo
			read -s -t 6 -n 1 -p "Press any key to go back to the menu..."
			;;
		C|c|L|l)
			clear
			loop=0
			;;
		M|m)
			cmatrix -u 5 -bs
			;;
		R|r)
			reboot
			;;
		S|s)
			poweroff
			;;
		*)
			clear
			startxfce4
			loop=0
			;;
		esac
	done
else
	echo -e "\n\e[2m:: Xorg server is already running:"
	ps -p $(cat /tmp/.X0-lock)
fi
echo -n -e "\e[0m\n"
