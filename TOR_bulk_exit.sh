#!/bin/bash

bingrep=$(which grep);
binegrep=$(which egrep);
bintr=$(which tr);
binwc=$(which wc);
bincurl=$(which curl);
binsed=$(which sed);
binawk=$(which awk);

SEPARATOR=",";
ESCAPEDOT=0;
OUTPUTFOR="csv";
while getopts :hes:o: OPTION; do
        case $OPTION in
		h)
			echo "+"
			echo " Usage ${0} [options]"
			echo "+"
			echo "-h	this help"
			echo "-s	Separator char between each IP"
			echo "-e	Escape dot for use in regex (ex: 127\.0\.0\.1)"
			echo "-o	Output format (list or csv)."
			echo "  	for 'csv' you can specify a separator with -s"
			echo "  	default: csv"
			echo "+"

			exit;
		;;
		s)
			SEPARATOR=$OPTARG;
		;;
		o)
			OUTPUTFOR=$OPTARG;
		;;
		e)
			ESCAPEDOT=1;
		;;
	esac
done

if [ $ESCAPEDOT -eq 1 ]; then
	ESCAPECDM="s/\\./\\\\./g";
else
	ESCAPECDM="s/\\./\\./g";
fi

if [ "${OUTPUTFOR}" == "csv" ]; then
	PROXYLIST=$($bincurl -A "Mozilla/5.0 (compatible; theMiddleBlue/1.0; +https://github.com/theMiddleBlue)" -s "https://check.torproject.org/cgi-bin/TorBulkExitList.py?ip=1.1.1.1" | $binegrep '^[0-9]+\.' | $bintr "\n" "${SEPARATOR}" | $binsed -e ${ESCAPECDM} | $binawk '{print substr($0, 0, length($0)) }')
fi

if [ "${OUTPUTFOR}" == "list" ]; then
	PROXYLIST=$($bincurl -A "Mozilla/5.0 (compatible; theMiddleBlue/1.0; +https://github.com/theMiddleBlue)" -s "https://check.torproject.org/cgi-bin/TorBulkExitList.py?ip=1.1.1.1" | $binegrep '^[0-9]+\.' | $binawk '{print($1"\\n");}' | $binsed -e ${ESCAPECDM})
fi

echo -e ${PROXYLIST};
