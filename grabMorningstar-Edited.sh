#!/bin/zsh

if [[ -z $1 ]]
then
echo "$0 <stock ticker>"
else
stock=$1
performanceId=$(curl -s "https://www.morningstar.com/api/v1/search/entities?q=${stock}&limit=1" -H 'x-api-key: Nrc2ElgzRkaTE43D5vA7mrWj2WpSBR35fvmaqfte' -H 'Origin: https://www.morningstar.com'|/usr/local/bin/jq '.results | .[]?.performanceId' | sed -e 's/^"//' -e 's/"$//')
curl -s "https://api-global.morningstar.com/sal-service/v1/stock/keyratios/${performanceId}/data?clientId=MDC&benchmarkId=category&vers6ion=3.31.0" -H 'ApiKey: lstzFDEOhfFNMLikKa0am9mgEKLBl49T' -H 'Origin: https://www.morningstar.com' > /tmp/morningstar.out 
cat /tmp/morningstar.out | /usr/local/bin/jq '.growthRatio | .[]'
cat /tmp/morningstar.out | /usr/local/bin/jq '.financialHealth.debtToEquity'
cat /tmp/morningstar.out | /usr/local/bin/jq '.profitabilityRatio.netMargin'
if [[ -e /tmp/morningstar.out ]]
then
	rm -f /tmp/morningstar.out
fi
fi
