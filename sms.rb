require 'twilio-ruby'
require 'csv'
require 'dotenv/load'

account_sid = ENV['ACCOUNT_SID']
auth_token = ENV['AUTH_TOKEN']
from_numbers = ENV['FROM_NUMBERS']
client = Twilio::REST::Client.new(account_sid, auth_token)

begin
    froms = from_numbers.split(',')
    raise ValueError if froms.empty?
rescue
    puts 'ENV[\'FROM_NUMBERS\'] must be a comma-delimited set of numbers to send from'
    exit
end

messages_to_send = CSV.read('sms.csv')

CSV.open('sms_sent.csv', 'wb') do |out_csv|
    puts ['from','to','body','response_code','errs'].map{|e|'"'+e+'"'}.join(',')
    messages_to_send.each do |to, body|
        from = froms.sample
        #r = { :from => from, :to => to, :body => body }
        #puts r.to_s
        begin
            error_code = ''
            error_message = ''
            client.messages.create(
                from: from,
                to: to,
                body: body
            )
        rescue Twilio::REST::RequestError => e
            error_code = e.code
            error_message = e.message
        ensure
            puts [from, to, body, error_code, error_message].map{|e|'"'+e+'"'}.join(',')
        end
    end
end

#client.messages.create(
#from: from,
#to: to,
#body: "Hey friend!"
#)
