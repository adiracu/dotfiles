#!/bin/bash

# Set common hosts 
# It will yell if there is already an existing entry with a different ip
#    In that case, the change should happen manually/

# Set up common hosts 
hosts="10.220.11.29:aww-tashmi
10.220.11.58:svn-tashmi
10.220.75.93:testcomp
127.0.0.1:opr01c1_ITF2
127.0.0.1:SCM01_replica1
127.0.0.1:opr01c1
127.0.0.1:SCM01_replica2
"

(
IFS=$'\n'

first_time_writing=

for ipHostTuple in $hosts; do
	
	ipAddr=${ipHostTuple%:*}
	hostName=${ipHostTuple#*:}
	# strip spaces
	hostName=${hostName// /}

	if cat /etc/hosts | grep "${ipAddr}\s*${hostName}\s*$" &>/dev/null ;then
		# Contains the exact same IP - Host combination
		# do nada
		true
	elif cat /etc/hosts | grep ".*${hostName}\s*$" &>/dev/null ; then
		# Contains a different ip for that hostname
		currIp=`cat /etc/hosts | grep ".*${hostName}\s*$" | cut -d " " -f1`
		echo "For the hostname '${hostName}', a different ip is assigned : '${currIp}' , expected : '${ipAddr}'" 1>&2
		echo " No change performed" 1>&2
	else
		# Does not contain the IP - Host combination
		if [[ ! "${first_time_writing}" ]]; then
			time=`date`
			sudo -- sh -c  "echo -e '\n\n# Added by dotfiles on ${time}\n' >> /etc/hosts"
			first_time_writing=1
		fi

		sudo -- sh -c  "echo '${ipAddr}     ${hostName}' >> /etc/hosts"
	fi
done

)


