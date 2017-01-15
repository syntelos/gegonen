#!/bin/bash

function usage {
    cat<<EOF>&2
Synopsis

  $0 

Description

  Call './output.sh --update'.

Synopsis

  $0 "commit message" [push]

Description

  Call git commit with message, optionally push.

Synopsis

  $0 [--help|-?|?]

Description

  This message.

EOF
    return 1
}


if ./output.sh --update
then

    if [ "${1}" ]
    then
	case "${1}" in
	    -*|\?)
		usage
		;;
	    *)
		git commit -a -m "${1}"

		if [ "${2}" = "push" ]
		then
		    git push
		fi
		;;
	esac

    fi

else
    echo "$0: error from './output --update'."
    exit 1
fi
