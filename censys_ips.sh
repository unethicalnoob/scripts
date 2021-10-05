#!/bin/bash

red=$(tput setaf 1)
green=$(tput setaf 2)
blue=$(tput setaf 4)
reset=$(tput sgr0)

if [ -z "$1" ];
then
echo ""
echo "${red}No domain/search_query provided ${reset}"
echo ""
echo "${blue}Usage: ./censys_ips.sh -d domain ${reset}";
fi


option="${1}"
  case "${option}" in
        -h|--help)
                echo " "
                echo "Usage: ./censys_ips.sh -d domain.com"
                exit 0
                ;;

        -d|--domain)
		if [ -z "$2" ]; then echo "No domain provided";
                else
		domain=$2
                curl -X 'GET' \
 		'https://search.censys.io/api/v2/hosts/search?q="'"$domain"'"&per_page=2000' \
		-H 'accept: application/json' \
		-u 'a1bf2181-bcb1-45b1-88df-1c452a45790b:nst33MZMMWJO0eFZLEKUhUQ7MLqsigs7' \
		| jq . \
		| grep ip \
		| cut -d '"' -f 4 \
		| grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b"
		fi
		;;
        *)
        exit 1 ;;
  esac
