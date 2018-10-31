require 'twilio-ruby'
require 'csv'

account_sid = ENV['ACCOUNT_SID']
auth_token = ENV['AUTH_TOKEN']
from_numbers = ENV['FROM_NUMBERS']
client = Twilio::REST::Client.new(account_sid, auth_token)

begin
    froms = from_numbers.split(',')
    raise ValueError if froms.empty?
rescue
    puts "ENV['FROM_NUMBERS'] must be a comma-delimited set of numbers to send from"
    exit
end

client.messages.create(
from: from,
to: to,
body: "Hey friend!"
)
