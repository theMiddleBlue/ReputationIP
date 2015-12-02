# Reputation IP
set of bash scripts that download list of IP address with a bad reputation, from public database/website like: 
- MaxMind GeoIP Anonymous Proxies
- Tor Exit Nodes
- Project Honey Pot Directory of Dictionary Attacker IPs
- more repo coming soon...

very useful for integrate into regular expression or blacklist. It can escape dot (`\.`) and you can sepcify the field separator between each ip (`-s "|"`). The output can be a **list** (one ip per line) or **csv** (with a comma as default separator).

## Scripts and descriptions

Script | Description
------ | ------------
anonymous_proxy.sh | MaxMind GeoIP Anonymous Proxies
TOR_bulk_exit.sh | Tor Exit Nodes
project_honeypot.sh | Project Honey Pot Directory of Dictionary Attacker IPs

## Real Life usage example

#### Drop all Dictionary Attacker IPs from Project Honey Pot Directory:
```sh
./project_honeypot.sh -o list | egrep '[0-9\.]+' | awk '{ print "iptables -A INPUT -s " $1 " -j DROP" }'
```
```sh
iptables -A INPUT -s 85.16.128.242 -j DROP
iptables -A INPUT -s 95.130.11.147 -j DROP
iptables -A INPUT -s 162.248.9.218 -j DROP
iptables -A INPUT -s 95.130.11.178 -j DROP
iptables -A INPUT -s 159.253.1.177 -j DROP
# etc ...
```

#### Find Dictionary Attacker IPs in Nginx access logs
```sh
cat /usr/local/nginx/logs/access.log | egrep '(`./project_honeypot.sh -o csv -e -s "|"`)'
```
```sh
85.16.128.242 - - [26/Nov/2015:12:59:14 +0100] "GET / HTTP/1.0" 200 2461 "-"
95.130.11.147 - - [30/Nov/2015:18:32:09 +0100] "GET / HTTP/1.0" 200 2461 "-"
159.253.1.177 - - [01/Dec/2015:01:14:41 +0100] "GET / HTTP/1.0" 200 2461 "-"
# etc ...
```

## Syntax

### anonymous_proxy.sh
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
#### Example anonymous_proxy.sh
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

### TOR_bulk_exit.sh
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

#### Example TOR_bulk_exit.sh
same as anonymous_proxy.sh example

### Others scripts
all scripts have the same syntax.

# Contact
```
Andrea (aka theMiddle) Menin
themiddle@waf.blue
```
