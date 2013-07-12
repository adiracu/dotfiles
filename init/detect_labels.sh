#!/bin/bash

(
	#empty the file
	echo "" > ../conf/os_detected

	IFS=$':'

	while read OS_KEY CMD_TO_RUN EXPECTED_STRING_TO_CONTAIN ; do

		result=`eval ${CMD_TO_RUN} 2>/dev/null`

		if [[ "${result}" == *${EXPECTED_STRING_TO_CONTAIN}*  ]]; then
			echo "${OS_KEY}" > ../conf/os_detected
		# 	echo "IT IS ${OS_KEY}"
		# else
		# 	echo "IT IS NOT ${OS_KEY}"
		fi

	done < ../conf/os_detection_rules
)
