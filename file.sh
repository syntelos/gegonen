#!/bin/bash
#

function usage {
    cat<<EOF>&2


Synopsis

  $0 

Description

  Print current file date and item for file name extension 'tex'.


Synopsis

  $0  [a-z][a-z][a-z]

Description

  Print current file date and item for file name extension '\$1'.


Synopsis

  $0 %[i][+-]N

Description

  Delta arithmetic over current file number (%i+1) for single digit N.


EOF
    exit 1
}

#
#
fext=tex

del=0

#
#
while [ -n "${1}" ]
do
    case "${1}" in

	%d[+-][0-9])
	    exp="0 $(echo ${1} | sed 's/%d//; s/./& /;')"

	    del=$(( ${exp} ))

	    del="$(echo ${del} | sed 's/./& /; s/^ //; s/ $//; s/^[0-9]/+ &/;')"
	    ;;

	[+-]*)
	    usage 
	    ;;

	[a-z][a-z][a-z])
	    fext="${1}"
	    ;;
	\*)
	    fext="${1}"
	    ;;
	*)
	    usage
	    ;;
    esac
    shift
done

#
#
file=$(2>/dev/null ls gegonen-*.{tex,txt} | tail -n 1)

if [ -n "${file}" ]&&[ -f "${file}" ]
then

    dec=$(echo ${file} | sed 's%gegonen-%%; s%\.txt$%%; s%\.tex$%%;' )

    if [ "0" != "${del}" ]
    then
	dec=$(( ${dec} ${del} ))
    fi
else
    dec=1
fi

base="gegonen-${dec}"

file="${base}.${fext}"

echo "${file}"

exit 0
