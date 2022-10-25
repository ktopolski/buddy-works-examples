# Buddy.works - closing the loop with github integration

This setup is the most advanced one. Not only do we request testing from buddy.works pipeline, we also will receive issues in our github repository whenever GlobalAppTesting's tester submits one or marks the test case as failed.

It gets even more cool tho! We're going to use an option to **disable our PR from being merged** until the testing is completed. Then, depending on the testing outcome, we will either enable the PR to be merged if there were no issues or.. disable it from merging in case there were issues.

Please keep in mind that this setup uses **V1 version of our API**. This means that some of the fields are not permitted, while others are expanded.

## Variables used

### ENV variables

- `GAT_API_KEY` - API key generated [in our application](https://app.globalapptesting.com/organization-settings/api-settings)
- `GH_ACCESS_TOKEN` - Github access token generated for your Github account. You can use a fine-grained token with following permissions:
  - Read access for Pull Requests
  - Read+write access for Commit Statuses(only if using `wait_for_finished_testing` option)
  - Read+write access for Issues
- `DRY_RUN` - whether or not this should simulate real test request or be an actual, legit test request we will charge for

### `gat.json` variables

- `application_url` - URL to your application or link to mobile app store where your mobile application can be downloaded for testing(ie. Testflight)
- `name` - name of your test, ie. "Release 2022-11-02 buddy.works CI"
- `description` - instructions for our testers. You can tell them to just go with test cases or to also do some exploratory testing.
- `test_cases` - List of test cases for our testers. If you'd like to do only exploratory testing, set this one as an empty array `[]`. If you do so, it's a good idea to put more information about your application and what parts of it you'd like tested into the description.
- `vendor` - marks the name of the integration. Should be left as `github`.
- `export_settings.github.repository` - repository slug, something like `youraccount/yourrepo`. Will use buddy's special variable - `$BUDDY_REPO_SLUG`.
- `export_settings.github.access_token` - Github access token. See `ENV variables` section for more information.
- `export_settings.github.pr_number` - Number of your Pull Request as Integer. Only needed if using `wait_for_finished_testing` option.
- `export_settings.github.wait_for_finished_testing` - Special integration for Github Pull Requests. If set to true, Pull Request will be marked as "Pending" and you won't be able to merge it until the testing process is completed. All of the issues and failed test case reports you'll get will be associated with this Pull Request. When the testing is finished, depending on whether or not GAT has reported any issues or failed test case reports, your Merge button will be active or not. **Completely optional flow :)**

#### Customizing the github integration

Apart from all the variables mentioned above, you can include bonus ones:

- `export_settings.github.pr_status_context` - commit status API's context message. The default one is just "GlobalAppTesting", but you can change that to hide our services as an implementation detail. For example, you can replace it with "Crowdtesting".
- `issue_prefix` - pretty self explanatory. The default one is an empty string. In case you're running a monorepo, you can use it for marking the components. You can setup your CI in a way to request two tests with us, one for your mobile app, second for web UI. Then you can use `issue_prefix` as `[Mobile app]` to know which components passed the testing and which did not.

## Integrating with Buddy

You're free to just copy paste the `curl_script.sh` into an action using "Ubuntu & Docker CLI" action. Of course better way would be setting up at least `GAT_API_KEY` to be an encrypted ENV variable inside Buddy UI. You can mark everything other as Settable variable so you'll be able to play with settings each run.

You will also need to provide a file called `gat.json`. For an easier start, you can use the sample ones I've attached to this README.

### YAML

You can also import my test pipeline from the yaml attached next to this README. Enjoy! :)
