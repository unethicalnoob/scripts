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
echo "${blue}Usage: ./shodan_ports.sh -l iplist ${reset}";
fi

option="${1}"
  case "${option}" in
        -h|--help)
                echo " "
                echo "Usage: ./censys_port.sh -l iplist.txt"
                exit 0
                ;;

        -l|--list)
                if [ -z "$2" ]; then echo "No ip list provided";
                else
                for ip in $(cat $2);
                do
			curl -X GET 'https://www.shodan.io/host/'$ip'?key=W2S4XQGC6ZRBzhufzsvGg2kxHikHGhAb' -s \
			| grep ports \
			| grep -o '[0-9]*' \
			| sort -un \
			| paste -sd,
		done
                fi
                ;;
        *)
        exit 1 ;;
  esac
