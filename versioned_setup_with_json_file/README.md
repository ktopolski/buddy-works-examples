# Buddy.works - versioned setup with JSON file

This setup exchanges simplicity of ENV variables for the ability to keep your testing data in the repository. The biggest wins are obviously versioning and to keeping test data easy to review and track the changes. The only variables left in ENV are `GAT_API_KEY` & `DRY_RUN`. 

There's also one more plus to this setup. It's easy to structure your test cases in a way that they are scoped to the components. So, if you'd like to use [GlobalAppTesting](https://globalapptesting.com) to test only part of your application(ie. depending on the git diff for the PR), you can use `jq` to select only test cases for this part.


## Variables used

### ENV variables

- `GAT_API_KEY` - API key generated [in our application](https://app.globalapptesting.com/organization-settings/api-settings)
- `DRY_RUN` - whether or not this should simulate real test request or be an actual, legit test request we will charge for

### `gat.json` variables

- `application_url` - URL to your application or link to mobile app store where your mobile application can be downloaded for testing(ie. Testflight)
- `name` - name of your test, ie. "Release 2022-11-02 buddy.works CI"
- `description` - instructions for our testers. You can tell them to just go with test cases or to also do some exploratory testing.
- `credentials_and_access_instructions` - pretty self explanatory. If you need testers to go through auth wall, this is the field where you tell them how to do exactly that.
- `test_cases` - List of test cases for our testers. If you'd like to do only exploratory testing, set this one as an empty array `[]`. If you do so, it's a good idea to put more information about your application and what parts of it you'd like tested into the description.

## Integrating with Buddy

You're free to just copy paste the `curl_script.sh` into an action using "Ubuntu & Docker CLI" action. Of course better way would be setting up at least `GAT_API_KEY` to be an encrypted ENV variable inside Buddy UI. You can mark everything other as Settable variable so you'll be able to play with settings each run.

You will also need to provide a file called `gat.json`. For an easier start, you can use the sample ones I've attached to this README.

### YAML

You can also import my test pipeline from the yaml attached next to this README. Enjoy! :)
