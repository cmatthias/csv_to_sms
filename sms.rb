require 'twilio-ruby'
require 'csv'
require 'dotenv/load'

account_sid = ENV['ACCOUNT_SID']
auth_token = ENV['AUTH_TOKEN']
from_numbers = ENV['FROM_NUMBERS']
client = Twilio::REST::Client.new(account_sid, auth_token)

#begin
    froms = from_numbers.split(',')
    raise ValueError if froms.empty?
#rescue
##    puts "ENV['FROM_NUMBERS'] must be a comma-delimited set of numbers to send from"
#  exit
#end
puts "Froms: #{froms}"

# number,message
# number,message
#  etc...
messages_to_send = CSV.read('sms.csv')

#client.messages.create(
#from: from,
#to: to,
#body: "Hey friend!"
#)
