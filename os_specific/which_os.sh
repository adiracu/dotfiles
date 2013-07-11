#!/bin/bash

(
	IFS=$':'

	while read OS_KEY CMD_TO_RUN EXPECTED_STRING_TO_CONTAIN ; do

		echo $OS_KEY
		echo $CMD_TO_RUN
		echo $EXPECTED_STRING_TO_CONTAIN

	done < detection
)
