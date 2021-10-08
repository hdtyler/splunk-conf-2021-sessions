#! env bash
for block in 0 50 100 150 200; do
  echo $block
  # Use your browser to view the call for "https://events.rainfocus.com/api/search" when viewing the event list, copy and paste there here, below is an example call with redacted values.
  curl 'https://events.rainfocus.com/api/search' -X POST -H 'User-Agent: <redacted>' -H 'Accept: */*' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' -H 'rfWidgetId: <redacted>' -H 'rfApiProfileId: <redacted>' -H 'rfAuthToken: <redacted>' -H 'Origin: https://conf.splunk.com' -H 'Sec-Fetch-Dest: empty' -H 'Sec-Fetch-Mode: cors' -H 'Sec-Fetch-Site: cross-site' -H 'Referer: https://conf.splunk.com/' -H 'Connection: keep-alive' -H 'Cookie: JSESSIONID=<redacted>' -H 'Pragma: no-cache' -H 'Cache-Control: no-cache' --data-raw 'type=session&size=50&from='${block} > classes_${block}.json
done
