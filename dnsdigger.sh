#!/bin/bash
domain=$2

function help {
	echo "$0 example.com

Usage:
    	$0 example.com

Example:
	$0 -a example.com #dns lookup
	$0 -r 1.2.3.4  #reverse dns lookup

OPTIONS:

	-a  | --all 		To show all the records
	-A  | --A		To show IPv4 address record alone
	-qa | --AAAA 		To show IPv6 address of the host
	-m  | --mx		To show mail record
	-c  | --cname           canonical name record
	-ca | --caa		Certification Authority Authorization record
	-lo | --loc		Geo Location record
	-s  | -srv		Service Record
	#-e  | --email		DNS Admin record
	-soa | --start		SOA record
	-r  | --revdns		Gives Host name for the given IP
	-t  | --txt		text record
	-h  | --help		show usage menu
"}


function any {
if [ ${#} -ne 1 ] ; then 

echo "------------comman dns query----------"
dig ANY +noall +answer +comments ${domain} @8.8.8.8
fi
}

function arecord {
if [ ${#}  -ne 1 ]; then
echo "--------------A  record -IPv4 --------------"
dig A +noall +answer +comments  ${domain} @8.8.8.8
fi
}

function qrecord {
if [ ${#} -ne 1]; then
echo "-------------A record IPv6 Address ------------"
dig AAAA +noall +answer +comments ${domain} @8.8.8.8
fi
}

function cname {
if [ ${#} -ne 1 ]; then
echo "------------CNAME record-----------"
dig CNAME +noall +answer +comments ${domain} @8.8.8.8
fi
}
 
function mail {
if [ ${#} -ne 1 ]; then
echo "-----------mail record----------"
dig MX +noall +answer +comments ${domain} @8.8.8.8
fi
}

function text {
if [ ${#} -ne 1 ]; then
echo "----------TXT record----------------"
dig TXT +noall +answer +comments ${domain} @8.8.8.8
fi
}

function geoloc {
if [ ${#} -ne 1 ]; then
echo "-----------GEO Location--------------"
dig LOC +noall +answer +comments ${domain} @8.8.8.8
fi
}

function service {
if [ ${#} -ne 1 ]; then
echo "----------service record------------"
dig SRV +noall +answer +comments ${domain} @8.8.8.8
fi
}

function certificate {
if [ ${#} -ne 1 ]; then
echo "-----------Certificate Authority Authorization record----------"
dig CAA +noall +answer +comments ${domain} @8.8.8.8
fi
}

function soarec {
if [ ${#} -ne 1 ]; then
echo "-------SOA record---------"
dig SOA +noall +answer +comments ${domain} @8.8.8.8
fi
}

function  revdns {
if [ ${#0} -ne 1 ]; then
echo "-------Reverse DNS Lookup--------"
dig -x ${domain} @8.8.8.8
fi

}


if [ -z "$1"]; then
	echo "Error!! Please specify the domain"
	
	exit 1

fi
while [ "$1" != ""]; do
	case $1 in
		-a | --all )
		any
		shift 2
		;; 
	 	-A | --A )
		arecord
		shift 2
  		;;
		-qa | --AAAA )
		qrecord
		shift 2
		;;
		-m | --MX )
		mail
		shift 2
		;;
		-c | --cname )
		cname
		shift 2
       	;;
		-ca | -caa )
		certificate
		shift 2
		;;
		-lo | --loc )
		geoloc
		shift 2
		;;
		-s | --srv )
		service
		shift 2
		;;
		-soa | --start )
		soarec
		shift 2
		;;
		-r | --revdns )
		revdns
		shift 2
		;;
		-t | --txt )
		text
		shift 2
		;;
		-h | --help )
		help
		shift 2
		exit
		;;
		* )
		help
		exit 1
		;;
	esac
done
