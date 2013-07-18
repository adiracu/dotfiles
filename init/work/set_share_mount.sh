#!/bin/bash

# Checks fstab to see if auto mounting of windows shares is present into ~/Shares
#  If they are present under a different mount point, it will yell and do nothing
#  If they are not present, it asks for the windows username and password and adds them (in cleartext) to fstab

shareNames="//10.220.73.111/ORG:${HOME}/Shares/org
//10.220.73.111/ORG/PUBLIC:${HOME}/Shares/public
//10.220.73.111/RND:${HOME}/Shares/rnd
//10.220.73.111/RND/RD_DE_CS/HIS:${HOME}/Shares/his
"

(

COLOR_PLAIN_RED="\033[0;31m"
COLOR_BOLD_RED="\033[1;31m"
COLOR_OFF="\033[0m"

IFS=$'\n'

first_time_writing=1
username=
password=

for serverSharePointTuple in $shareNames; do

	server=${serverSharePointTuple%:*}
	mountPoint=${serverSharePointTuple#*:}
	# strip spaces; sometimes typos
	mountPoint=${mountPoint// /}

	if cat /etc/fstab | grep "^${server} ${mountPoint}.*$" &>/dev/null ;then
		# Contains the exact same serv - share point combo
		# do nada
		true
	elif cat /etc/fstab | grep "^${server} .*$" &>/dev/null ; then
		# Contains a different ip for that hostname
		currMountPoint=`cat /etc/fstab | grep "^${server} .*$" | cut -d " " -f2`
		echo "For the server '${server}', a different mount point is used : '${currMountPoint}' , expected : '${mountPoint}'" 1>&2
		echo " No change performed" 1>&2
	else

		# Does not contain the IP - Host combination
		if [[  "${first_time_writing}" ]]; then
			time=`date`

			echo "Adding server ${server} to mountpoint ${mountPoint}. Credentials are needed (these will be stored in plaintext)."
			echo -e "${COLOR_BOLD_RED}(c)${COLOR_PLAIN_RED}ontinue or ${COLOR_BOLD_RED}(a)${COLOR_PLAIN_RED}bort (10 second timeout)? ${COLOR_OFF}"
			# -r     : don't allow backslashes
			# -s     : don't echo key presses back to the terminal
			# -n 1   : only allow 1 character
			# -t 10  : timeout of 10 seconds
			read -r -s -n 1 -t 10 response

			if test ${response} = "c" ; then
				echo -n "Windows username: "
				read -r username
				echo -n "Windows password: "
				read -r password
			else
				echo " Exitting"
				exit 1
			fi

			sudo -- sh -c  "echo -e '\n\n# Added by dotfiles on ${time}\n' >> /etc/fstab"

			first_time_writing=
		fi

		sudo -- sh -c  "echo '${server} ${mountPoint} cifs uid=1000,gid=100,username=$username,password=$password,domain=ad-01.ent-01.adgroup' >> /etc/fstab"
	fi
done

)
