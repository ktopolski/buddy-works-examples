# export GAT_API_KEY="get yours at https://globalapptesting.com" ;)
# export GH_ACCESS_TOKEN="get yours at your github account's settings page"
export DRY_RUN=true

sudo apt-get install -yqq jq

app_url=`jq -cM .application_url < gat.json`
test_name=`jq -cM .name < gat.json`
test_description=`jq -cM .description < gat.json`
test_cases=`jq -cM .test_cases < gat.json`

test_run_path="https://app.globalapptesting.com/api/v1/flexible_testing/test_requests"
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
        \"vendor\":\"github\",
        \"export_settings\":{
          \"github\":{
	          \"repository\":\"$BUDDY_REPO_SLUG\",
	          \"access_token\":\"$GH_ACCESS_TOKEN\",
	          \"pr_number\":1,
	          \"wait_for_finished_testing\":true
          }
        }
      }
    }
  }" \
  $api_url
