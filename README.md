Put your messages in a CSV file called `sms.csv`. Each line should look like `to_number,message`, e.g.:
```
"1234561111","Hello there"
"1233759999","Hello to you as well"
```

Then, do the following:

1. Ensure you have bundler installed
1. `bundle install`
1. set up `.env` file. Required values:
    * `ACCOUNT_SID=ACxxxxxxxxxxxxxxxxxxxx`
    * `AUTH_TOKEN=xxxxxxxx`
    * `FROM_NUMBERS=1234567890,2345678901`
       <-- This last one should be a comma-delimited list of valid Twilio numbers to send from
1. `bundle exec ruby sms.rb`