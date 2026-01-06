#!/bin/bash

if [ "$(echo $MAKE_JOBS)" = "" ]; then
	echo "ERROR: \$MAKE_JOBS is not set"
	exit 1
fi

Scripts/Additional-Packages/wget.sh    || exit 1
Scripts/Additional-Packages/openssh.sh || exit 1
