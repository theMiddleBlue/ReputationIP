# Reputation IP
set of bash scripts that download list of IP address with a bad reputation, from public database/website like: 
- Anonymous Proxy https://www.maxmind.com/en/proxy-detection-sample-list
- Tor Bulk Exit https://check.torproject.org/cgi-bin/TorBulkExitList.py?ip=1.1.1.1
- more repo coming soon...

very useful for integrate into regular expression or blacklist

## anonymous_proxy.sh
Download from maxmind.com a list of 250 Open Proxy. From https://www.maxmind.com/en/proxy-detection-sample-list 
"most used IP addresses in the minFraud network that have been identified by the Proxy Detection service as higher risk."
```
# ./anonymous_proxy.sh -h
+
 Usage ./anonymous_proxy.sh [options]
+
-h	this help
-s	Separator char between each IP
-e	Escape dot for use in regex (ex: 127\.0\.0\.1)
-o	Output format (list or csv).
  	for 'csv' you can specify a separator with -s
  	default: csv
+
```
### Example anonymous_proxy.sh
```sh
# ./anonymous_proxy.sh -o list -e | more
5\.9\.36\.66
5\.9\.158\.75
5\.28\.62\.85
5\.39\.79\.8
5\.79\.68\.161
5\.79\.74\.233
5\.135\.66\.213
5\.135\.143\.104
5\.135\.158\.101
# etc...
```

```
# ./anonymous_proxy.sh -o csv -s "|"
5.9.36.66|5.9.158.75|5.28.62.85|5.39.79.8|5.79.68.161|5.79.74.233|5.135.66.213|5.135.143.104....
```

## TOR_bulk_exit.sh
```
# ./TOR_bulk_exit.sh -h
+
 Usage ./TOR_bulk_exit.sh [options]
+
-h	this help
-s	Separator char between each IP
-e	Escape dot for use in regex (ex: 127\.0\.0\.1)
-o	Output format (list or csv).
  	for 'csv' you can specify a separator with -s
  	default: csv
+
```

### Example TOR_bulk_exit.sh
same as anonymous_proxy.sh example

# Contact
```
Andrea (aka theMiddle) Menin
themiddle@waf.blue
```
