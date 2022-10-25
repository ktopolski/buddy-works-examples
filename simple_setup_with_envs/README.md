# Buddy.works - simple setup with ENVs

This is the simplest setup for requesting crowdtesting with [GlobalAppTesting](https://globalapptesting.com). Given that your test params will change frequently(ie. name, description, test cases), it's probably only good for testing the service.

## Variables used

- `GAT_API_KEY` - API key generated [in our application](https://app.globalapptesting.com/organization-settings/api-settings)
- `APP_URL` - URL to your application or link to mobile app store where your mobile application can be downloaded for testing(ie. Testflight)
- `TEST_NAME` - name of your test, ie. "Release 2022-11-02 buddy.works CI"
- `TEST_DESCRIPTION` - instructions for our testers. You can tell them to just go with test cases or to also do some exploratory testing.
- `CREDENTIALS_AND_ACCESS_INSTRUCTIONS` - pretty self explanatory. If you need testers to go through auth wall, this is the field where you tell them how to do exactly that.
- `DRY_RUN` - whether or not this should simulate real test request or be an actual, legit test request we will charge for

## Integrating with Buddy

You're free to just copy paste the `curl_script.sh` into an action using "Ubuntu & Docker CLI" action. Of course better way would be setting up at least `GAT_API_KEY` to be an encrypted ENV variable inside Buddy UI. You can mark everything other as Settable variable so you'll be able to play with settings each run.

You will also need to provide a file called `test_cases.json`. If you'd like to only run exploratory tests you can put an empty array `[]` there. However, if you'd like to provide our testers some steps to follow, you can use the sample ones I've attached next to this README.

### YAML

You can also import my test pipeline from the yaml attached next to this README. Enjoy! :)
