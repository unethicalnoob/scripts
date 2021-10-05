#!/bin/bash

red=$(tput setaf 1)
green=$(tput setaf 2)
blue=$(tput setaf 4)
reset=$(tput sgr0)

if [ -z "$1" ];
then
echo ""
echo "${red}No domain provided ${reset}"
echo ""
echo "${blue}Usage: ./censys_certificates.sh <domain_name> ${reset}";
fi

curl -X 'POST' \
  'https://search.censys.io/api/v1/search/certificates' \
  -H 'accept: application/json' -s \
  -u '68b629f0-b42e-4c5d-8bd6-d725d460ab5e:RJb2emWhZ4C1yMxVotEKAFYmg52Oh7q1' \
  -d '{
  "query":"'$domain'",
  "page": 1,
  "fields": [
    "parsed.names"
  ],
  "flatten": true
}' \
|jq \
| grep -o "".*\.$1"" \
| tr -d '"' \
| sort -u \
| tr -d "[:blank:]" \
| grep -v "query"
