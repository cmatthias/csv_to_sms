# CSV to SMS

## What is this?

This script will send Twilio SMS messages in bulk, using a CSV as input. It currently only sends messages serially, so you will probably have a bad time if you're trying to send a lot (thousands+) of messages.

## How do I use it?

Put the messages you want to send in a CSV file called `sms.csv`. Each line should look like `to_number,message`, e.g.:
```
"1234561111","Hello there"
"1233759999","Hello to you as well"
```

Then, do the following:

1. Ensure you have ruby and bundler installed (`gem install bundler` or `sudo gem install bundler`)
1. `bundle install`
1. Create a file called `.env` in the directory of this project. Feel free to use the included `.env.sample` file as a template. This file should have three environment variables in it as follows:
    * `ACCOUNT_SID=ACxxxxxxxxxxxxxxxxxxxx`
    * `AUTH_TOKEN=xxxxxxxx`
    * `FROM_NUMBERS=+11234567890,+12345678901`
       <-- This last one should be a comma-delimited list of valid Twilio numbers to send from
1. Run the script and send some messages! `bundle exec ruby sms.rb`

The script will print (to stdout) a resulting CSV in the format of:

```
from,to,body,error_code,error_message
```

with one row for each message send attempt. `error_code` and `error_message` will be empty if the message sent successfully.