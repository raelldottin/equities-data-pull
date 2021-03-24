#!/bin/zsh

if [[ -z $1 ]]
then
echo "$0 <stock ticker>"
else
stock=$(echo $1|sed -e 's/-/./')
exchange=$(curl -s "https://www.morningstar.com/api/v1/search/entities?q=${stock}&limit=1" -H 'x-api-key: Nrc2ElgzRkaTE43D5vA7mrWj2WpSBR35fvmaqfte' -H 'Origin: https://www.morningstar.com'|/usr/local/bin/jq '.results | .[]?.exchange' | sed -e 's/^"//' -e 's/"$//')
curl -s "https://www.morningstar.com/stocks/${exchange}/${stock}/quote"|grep -Eo "<span data-v-7ba8d775>[^<]+.</span>"|sed -e 's#<span data-v-7ba8d775>\(.*\)</span>#\1#'
curl -s "https://www.morningstar.com/stocks/${exchange}/${stock}/quote"|grep -Eo "<span itemprop=.numberOfEmployees. data-v-7ba8d775>[^<]+.</span>"|sed -e 's#<span itemprop="numberOfEmployees" data-v-7ba8d775>\(.*\)</span>#\1#'
fi
