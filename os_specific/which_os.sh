#!/bin/bash

(
	#empty the file
	echo "" > detected_os

	IFS=$':'

	while read OS_KEY CMD_TO_RUN EXPECTED_STRING_TO_CONTAIN ; do

		result=`eval ${CMD_TO_RUN} 2>/dev/null`

		if [[ "${result}" == *${EXPECTED_STRING_TO_CONTAIN}*  ]]; then
			echo "${OS_KEY}" > detected_os
		# 	echo "IT IS ${OS_KEY}"
		# else
		# 	echo "IT IS NOT ${OS_KEY}"
		fi

	done < detection_rules
)
