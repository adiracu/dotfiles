#!/bin/bash

(
	#empty the file
	echo "" > ~/.dotfiles/conf/labels_detected

	IFS=$':'

	while read OS_KEY CMD_TO_RUN EXPECTED_STRING_TO_CONTAIN ; do

		result=`eval ${CMD_TO_RUN} 2>/dev/null`

		if [[ "${result}" == *${EXPECTED_STRING_TO_CONTAIN}*  ]]; then
			echo "${OS_KEY}" > ~/.dotfiles/conf/labels_detected
		# 	echo "IT IS ${OS_KEY}"
		# else
		# 	echo "IT IS NOT ${OS_KEY}"
		fi

	done < ~/.dotfiles/conf/label_detection_rules
)
