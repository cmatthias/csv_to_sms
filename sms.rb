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

msgs = []
puts ['from','to','body','error_code','error_message'].map{|e|'"'+e+'"'}.join(',')
CSV.foreach('sms.csv') do |row|
    if row.size != 2
        # TODO: more error checking here? phone number format?
        puts "Malformed row on line #{$INPUT_LINE_NUMBER} of input csv"
        exit
    end
    msgs << {to: row[0], from: froms.sample, body: row[1]}
end

msgs.each do |msg|
    from = msg[:from]
    to = msg[:to]
    body = msg[:body]
    begin
        error_code = ''
        error_message = ''
        client.messages.create(
            from: from,
            to: to,
            body: body
        )
    rescue Twilio::REST::RestError => e
        error_code = e.code
        error_message = e.message
    ensure
        puts [from, to, body, error_code, error_message].map{|e|'"'+e+'"'}.join(',')
    end
end