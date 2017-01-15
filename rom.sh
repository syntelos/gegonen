#!/bin/bash
#
#
function usage {
    cat<<EOF>&2

Synopsis

  $0 

Description

  This message.


Synopsis

  $0 -rom R

Description

  Output decimal number for roman numeral R.


Synopsis

  $0 -dec D

Description

  Output roman numeral for decimal number D.


Notes

  Alternatively, the program name may be named one of "rom2dec" or
  "dec2rom" to replace the first argument.


EOF
    return 1
}

#
#
function dec2rom {
    dec="${1}"

    output=''

    if [ -n "${dec}" ]
    then

	mille=$(( ${dec} / 1000 ))
	if [ 0 != ${mille} ]
	then
	    dec=$(( ${dec} - $(( ${mille} * 1000 )) ))
	fi

	cent=$(( ${dec} / 100 ))
	if [ 0 != ${cent} ]
	then
	    dec=$(( ${dec} - $(( ${cent} * 100 )) ))
	fi

	quin=$(( ${dec} / 50 ))
	if [ 0 != ${quin} ]
	then
	    dec=$(( ${dec} - $(( ${quin} * 50 )) ))
	fi

	deca=$(( ${dec} / 10 ))
	if [ 0 != ${deca} ]
	then
	    dec=$(( ${dec} - $(( ${deca} * 10 )) ))
	fi

	quia=$(( ${dec} / 5 ))
	if [ 0 != ${quia} ]
	then
	    dec=$(( ${dec} - $(( ${quia} * 5 )) ))
	fi

	#
	#
	cc=0

	if [ 0 != ${mille} ]
	then
	    cc=0;
	    while [ ${cc} -lt ${mille} ]
	    do
		if [ -n "${output}" ]
		then
		    output="${output}M"
		else
		    output="M"
		fi
		cc=$(( ${cc} + 1 ))
	    done
	fi

	if [ 0 != ${cent} ]
	then
	    cc=0;
	    while [ ${cc} -lt ${cent} ]
	    do
		if [ -n "${output}" ]
		then
		    output="${output}C"
		else
		    output="C"
		fi
		cc=$(( ${cc} + 1 ))
	    done
	fi

	if [ 0 != ${quin} ]
	then
	    cc=0;
	    while [ ${cc} -lt ${quin} ]
	    do
		if [ -n "${output}" ]
		then
		    output="${output}L"
		else
		    output="L"
		fi
		cc=$(( ${cc} + 1 ))
	    done
	fi

	if [ 0 != ${deca} ]
	then
	    cc=0;
	    while [  ${cc} -lt ${deca} ] 
	    do
		if [ -n "${output}" ]
		then
		    output="${output}X"
		else
		    output="X"
		fi
		cc=$(( ${cc} + 1 ))
	    done
	fi

	if [ 0 != ${quia} ]
	then
	    cc=0;
	    while [ ${cc} -lt ${quia} ]
	    do
		if [ -n "${output}" ]
		then
		    output="${output}V"
		else
		    output="V"
		fi
		cc=$(( ${cc} + 1 ))
	    done
	fi

	if [ 0 != ${dec} ]
	then
	    cc=0;
	    while [ ${cc} -lt ${dec} ]
	    do
		if [ -n "${output}" ]
		then
		    output="${output}I"
		else
		    output="I"
		fi
		cc=$(( ${cc} + 1 ))
	    done
	fi
    fi

    if [ -n "${output}" ]
    then
	echo ${output} 
	return 0
    else
	return 1
    fi
}

#
#
function rom2dec {
    rom="${1}"

    output=''

    if [ -n "${rom}" ]
    then
	re=$(echo ${rom} | sed 's/.//')
	ch=$(echo ${rom} | sed "s%${re}\$%%")

	while [ -n "${ch}" ]
	do
	    case "${ch}" in

		[Mm])

		    if [ -n "${output}" ]
		    then
			output=$(( ${output} + 1000 ))
		    else
			output=1000
		    fi
		    ;;

		[Cc])

		    if [ -n "${output}" ]
		    then
			output=$(( ${output} + 100 ))
		    else
			output=100
		    fi
		    ;;

		[Ll])

		    if [ -n "${output}" ]
		    then
			output=$(( ${output} + 50 ))
		    else
			output=50
		    fi
		    ;;

		[Xx])

		    if [ -n "${output}" ]
		    then
			output=$(( ${output} + 10 ))
		    else
			output=10
		    fi
		    ;;

		[Vv])

		    if [ -n "${output}" ]
		    then
			output=$(( ${output} + 5 ))
		    else
			output=5
		    fi
		    ;;

		[Ii])

		    if [ -n "${output}" ]
		    then
			output=$(( ${output} + 1 ))
		    else
			output=1
		    fi
		    ;;

	    esac
	    #

	    rom=${re}

	    re=$(echo ${rom} | sed 's/.//')

	    ch=$(echo ${rom} | sed "s%${re}\$%%")

	done
	#
    fi

    if [ -n "${output}" ]
    then
	echo ${output} 
	return 0
    else
	return 1
    fi
}

#
#
#
case "${0}" in
    rom2dec*)
	op="-rom"
	;;
    dec2rom*)
	op="-dec"
	;;
esac
#
#
#
if [ -n "${1}" ]&&[ -n "${2}" ]
then
    op="${1}"
    arg="${2}"

    case "${op}" in
	-rom)
	    rom2dec "${arg}"
	    ;;
	-dec)
	    dec2rom "${arg}"
	    ;;
	*)
	    usage
	    ;;
    esac

elif [ -n "${1}" ]
then

    arg="${2}"

    case "${op}" in
	-rom)
	    rom2dec "${arg}"
	    ;;
	-dec)
	    dec2rom "${arg}"
	    ;;
	*)
	    usage
	    ;;
    esac
else
    usage
fi
