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
		\Z1\Zr C \ZR\Z4ommand \Znor \Z1\Zr L \ZR\Z4inux\Zn for command line prompt;\n\n
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
			read -s -n 1 -p "Press any key to go back to the menu..."
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
			if ( lsmod | grep "nvidia" &> /dev/null ) && ( test -e /etc/X11/xorg.conf.d/20-nvidia.conf.renamedtousenouveau )
		        then
				echo "Using Nvidia proprietary drivers. Config file needed. Enter root password to start Xfce4:"
				sudo mv /etc/X11/xorg.conf.d/20-nvidia.conf.renamedtousenouveau /etc/X11/xorg.conf.d/20-nvidia.conf
			elif ( lsmod | grep "nouveau" &> /dev/null ) && ( test -e /etc/X11/xorg.conf.d/20-nvidia.conf )
			then
				echo "Using nouveau driver. Nvidia config file found in /etc/X11/xorg.conf.d/ (must be renamed, so it won't be read by the system). Enter root password to confirm:"
				sudo mv /etc/X11/xorg.conf.d/20-nvidia.conf /etc/X11/xorg.conf.d/20-nvidia.conf.renamedtousenouveau
			fi
			startxfce4
			;;
		esac
	done
else
	echo -e "\n\e[2m:: Xorg server is already running:"
	ps -p $(cat /tmp/.X0-lock)
fi
echo -n -e "\e[0m\n"
