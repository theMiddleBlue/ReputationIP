#!/bin/bash

bingrep=$(which grep);
binwc=$(which wc);
bincurl=$(which curl);
binsed=$(which sed);
binawk=$(which awk);

SEPARATOR=",";
ESCAPEDOT=0;
OUTPUTFOR="csv";
while getopts :hes:o:u:p: OPTION; do
        case $OPTION in
		h)
			echo "+"
			echo " Usage ${0} [options]"
			echo "+"
			echo "-h 	this help"
			echo "-s 	Separator char between each IP"
			echo "-e 	Escape dot for use in regex (ex: 127\.0\.0\.1)"
			echo "-o 	Output format (list or csv)."
			echo "-u 	WAF.Red Username"
			echo "-p 	WAF.Red Password"
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
		u)
			USERNAME=$OPTARG;
		;;
		p)
			PASSWORD=$OPTARG;
		;;
		e)
			ESCAPEDOT=1;
		;;
	esac
done

if  [ -z $USERNAME ]; then
	echo "Error: set WAF.Red username with -u";
	exit 0;
fi

if  [ -z $PASSWORD ]; then
	echo "Error: set WAF.Red password with -p";
	exit 0;
fi

if [ $ESCAPEDOT -eq 1 ]; then
	ESCAPECDM="s/\\./\\\\./g";
else
	ESCAPECDM="s/\\./\\./g";
fi

if [ "${OUTPUTFOR}" == "csv" ]; then
	WAFRED=$($bincurl -A "Mozilla/5.0 (compatible; theMiddleBlue/1.0; +https://github.com/theMiddleBlue)" -u "${USERNAME}:${PASSWORD}" -s "https://node1.waf.red/api/scream48.com/blacklist/list" | while read line; do if [[ "$line" =~ ([0-9\.]+) ]]; then echo ${BASH_REMATCH[1]}; fi done | tr "\n" "${SEPARATOR}" | $binsed -e ${ESCAPECDM} | $binawk '{print substr($0, 0, length($0)) }')
fi

if [ "${OUTPUTFOR}" == "list" ]; then
	WAFRED=$($bincurl -A "Mozilla/5.0 (compatible; theMiddleBlue/1.0; +https://github.com/theMiddleBlue)" -u "${USERNAME}:${PASSWORD}" -s "https://node1.waf.red/api/scream48.com/blacklist/list" | while read line; do if [[ "$line" =~ ([0-9\.]+) ]]; then echo -n "${BASH_REMATCH[1]}\\n"; fi done | $binsed -e ${ESCAPECDM})
fi

echo -e ${WAFRED};
