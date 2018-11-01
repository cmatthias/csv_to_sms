# CSV to SMS

## What is this?

This script will send Twilio SMS messages in bulk, using a CSV as input. It currently only sends messages serially, so you will probably have a bad time if you're trying to send a lot (thousands+) of messages.

## How do I use it?

Put the messages you want to send in a CSV file called `sms.csv`. Each line should look like `meta,to_number,message`. `meta` is a field for passing an id or other tracking parameter -- nothing will be done with it but it will be passed back in the output. Set it to the empty string `""` if you don't want to use it.

Here's an example input file:

```
"id12345","+11234561111","Hello there"
"id23456","+11233759999","Hello to you as well"
"","+14132223333","Hello without meta"
```

Then, do the following:

1. Ensure you have ruby and bundler installed (`gem install bundler` or `sudo gem install bundler`)
1. `bundle install`
1. Create a file called `.env` in the directory of this project. Feel free to use the included `.env.sample` file as a template. This file should have three environment variables in it as follows:
    * `ACCOUNT_SID=ACxxxxxxxxxxxxxxxxxxxx`
    * `AUTH_TOKEN=xxxxxxxx`
    * `FROM_NUMBERS=+11234567890,+12345678901`
       <-- This last one should be a comma-delimited list of valid Twilio numbers to send from. The script will randomly choose one of these numbers to send each message from.
1. Run the script and send some messages! `bundle exec ruby sms.rb`

The script will print (to stdout) a resulting CSV in the format of:

```
meta,from,to,body,error_code,error_message
```

with one row for each message send attempt. `error_code` and `error_message` will be empty if the message sent successfully.