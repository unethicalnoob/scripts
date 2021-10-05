#!/bin/bash
red=$(tput setaf 1)
green=$(tput setaf 2)
blue=$(tput setaf 4)
reset=$(tput sgr0)

if [ -z "$1" ];
then
echo ""
echo "${red}No ip list provided ${reset}"
echo ""
echo "${blue}Usage: ./nmap_init.sh -f iplist.txt ${reset}";
fi

option="${1}"
  case "${option}" in
	-h|--help)
		echo " "
		echo "Usage: ./nmap_init.sh -n iplist.txt (For normal scan)"
		echo " "
		echo "Usage: ./nmap_init.sh -f iplist.txt (Firewall bypass scan)"
		exit 0
		;;
	-f|--firewall)
		if [ -z "$2" ]; then echo "No IP list provided";
		else
		nmap --max-rtt-timeout=450ms --max-retries=5 --version-intensity=0 --max-scan-delay=10ms --min-rate=5000 --reason -Pn -n -p 0-65535 -oX $2.xml -oN $2.txt -iL $2
		fi
		;;
	-n|--normal)
		if [ -z "$2" ]; then echo "No IP list provided";
		else
		nmap -sV -sT -Pn -p 1-65535 -oX version_scan_$2.xml -oN version_scan_$2.txt -iL $2
		fi
		;;
	*)
	exit 1 ;;
  esac
