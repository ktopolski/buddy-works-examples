# export GAT_API_KEY="get yours at https://globalapptesting.com" ;)
export APP_URL="https://your-app.com"
export TEST_NAME="Buddy.works demo - simple setup with ENVs"
export TEST_DESCRIPTION="Please don't limit yourself to test cases, we're open to exploratory testing issues too!"
export CREDENTIALS_AND_ACCESS_INSTRUCTIONS="Login as awesome.user@buddy.works / hopefullyGeneratedPassword"
export DRY_RUN=false

test_cases=`cat test_cases.json`
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
        \"description\":\"$TEST_DESCRIPTION\",
        \"name\":\"$TEST_NAME\",
        \"application_url\":\"$APP_URL\",
        \"test_cases\":$test_cases,
        \"credentials_and_access_instructions\":\"$CREDENTIALS_AND_ACCESS_INSTRUCTIONS\"
      }
    }
  }" \
  $api_url
