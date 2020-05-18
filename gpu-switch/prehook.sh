#!/bin/bash

if test -f /tmp/target-gpu; then
	TARGET=$(cat /tmp/target-gpu)

	sudo /usr/local/bin/switch-gpu $TARGET

	rm /tmp/target-gpu

	if [ "$TARGET" == "nvidia" ]; then
		touch /tmp/pls-fix-reset-bug
	fi
fi

