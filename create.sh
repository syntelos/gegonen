#!/bin/bash

if file=$(./file.sh '%d+1' ) && [ -n "${file}" ]
then

    if dec=$(echo ${file} | sed 's/gegonen-//; s/\.tex$//;' ) && [ -n "${dec}" ]
    then
	rom=$(./rom.sh -dec ${dec} )

	cat<<EOF>${file}
\input gegonen

\centerline{\bf Gegonen ${rom}}

\smallskip

\centerline{John Douglas Harold Pritchard}

\break







\bye
EOF

	echo ${file}

	git add ${file}

	emacs ${file} &

    else
	cat<<EOF>&2
$0: Error extracting number from file '${file}'.
EOF
	exit 1
    fi

else
    cat<<EOF>&2
$0: File not found.
EOF
    exit 1
fi

