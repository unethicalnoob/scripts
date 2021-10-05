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
echo "${blue}Usage: ./censys_org.sh -l iplist.txt ${reset}";
fi

option="${1}"
  case "${option}" in
        -h|--help)
                echo " "
                echo "Usage: ./censys_org.sh -l iplist.txt"
                exit 0
                ;;

        -l|--list)
                if [ -z "$2" ]; then echo "No ip list provided";
                else
                for ip in $(cat $2);
                do
                    curl -X 'GET' \
                    'https://search.censys.io/api/v2/hosts/'$ip'' \
                    -H 'accept: application/json' -s \
                    -u '68b629f0-b42e-4c5d-8bd6-d725d460ab5e:RJb2emWhZ4C1yMxVotEKAFYmg52Oh7q1' \
                     | jq . \
                     | grep -E '"name":|"ip":|"port":'
                done
                fi
                ;;
        *)
        exit 1 ;;
  esac
