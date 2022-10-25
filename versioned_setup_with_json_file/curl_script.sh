# export GAT_API_KEY="get yours at https://globalapptesting.com" ;)
export DRY_RUN=true

sudo apt-get install -yqq jq

app_url=`jq -cM .application_url < gat.json`
test_name=`jq -cM .name < gat.json`
test_description=`jq -cM .description < gat.json`
credentials_and_access_instructions=`jq -cM .credentials_and_access_instructions < gat.json`
test_cases=`jq -cM .test_cases < gat.json`

test_run_path="https://app.globalapptesting.com/api/v2/test_requests"
dry_run_path=$test_run_path/dry_run
if [[ $DRY_RUN == "true" ]]; then
  api_url=$dry_run_path
else
  api_url=$test_run_path
fi

curl \
  --fail \
  -X POST \
  -H 'Content-type: application/vnd.api+json' \
  -H "X-Api-Key: $GAT_API_KEY" \
  -d "{
    \"data\":{
      \"type\":\"testRequest\",
      \"attributes\":{
        \"description\":$test_description,
        \"name\":$test_name,
        \"application_url\":$app_url,
        \"test_cases\":$test_cases,
        \"credentials_and_access_instructions\":$credentials_and_access_instructions
      }
    }
  }" \
  $api_url
