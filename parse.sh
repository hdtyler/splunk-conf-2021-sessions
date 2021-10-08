#! env bash

set -ex

parse () {
  if [[ ${1} == "0" ]]; then
    jq '.sectionList[].items[]' "${2}" | jq -s .
  else
    jq '.items[]' "${2}" | jq -s .
  fi
}

filter () {
  if [[ ${1} == "0" ]]; then
    jq '.sectionList[].items[] | {session_code: .abbreviation, title: .title, abstract: .abstract, first_speaker: .participants[0].fullName, start_time_utc: .times[].utcStartTime, end_time_utc: .times[].utcEndTime}' ${2} | jq -s .
  else
    jq '.items[] | {session_code: .abbreviation, title: .title, abstract: .abstract, first_speaker: .participants[0].fullName, start_time_utc: .times[].utcStartTime, end_time_utc: .times[].utcEndTime}' ${2} | jq -s .
  fi
}


for block in 0 50 100 150 200; do
    parse "${block}" "classes_${block}.json" > classes_${block}_parsed.json
done

jq -s 'map(.[])' classes_*parsed.json > classes_all_parsed.json

# Filter down to just a few useful fields for easy consumption 
jq '.[] | {session_code: .abbreviation, title: .title, abstract: .abstract, first_speaker: .participants[0].fullName, start_time_utc: .times[].utcStartTime, end_time_utc: .times[].utcEndTime}' classes_all_parsed.json | jq -s . > classes_all_filtered.json

# https://stackoverflow.com/questions/32960857/how-to-convert-arbitrary-simple-json-to-csv-using-jq
jq -r '(map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @csv' classes_all_filtered.json > classes_all_filtered.csv