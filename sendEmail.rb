#using SendGrid's Ruby Library
# https://github.com/sendgrid/sendgrid-ruby
require 'sendgrid-ruby'
require 'csv'
require 'base64'
require 'open-uri'
include SendGrid

#ARGV[0] takes the file path
CSV.foreach(ARGV[0]) do |row|

  from = Email.new(email: 'ebairagi1@student.gsu.edu')
  to = Email.new(email: "#{row[0]}")
  #to = Email.new(email: 'ebairagi1@student.gsu.edu')
  subject = 'GRA opportunity'
  content = Content.new(type: 'text/plain', 
                        value: "Hello #{row[1]},

                       Hope you are doing great.
                       I am a Graduate Student, pursuing my masters in information systems in GSU.
                       And I really need a GRA to reduce my tution fee load.
                       I am writing this email to check if any GRA position 
                       opened up with you for spring semester.
                       I have 5+ years of work experience, also I am attaching my Resume for reference.
                       Kindly Let me know of you need any information from my side to proceed further.

                       Thanks and Regards,
                       Eshan Bairagi
                       +1 (470) 399-3215                          
                       https://www.linkedin.com/in/eshan-bairagi-2675a4b/")

  mail = Mail.new(from, subject, to, content)
  attachment = Attachment.new
  attachment.content = Base64.strict_encode64(open('/home/eashan/Documents/Eshan_Bairagi.pdf'){ |io| io.read })
  attachment.type = 'application/pdf'
  attachment.filename = 'Eshan_Bairagi.pdf'
  attachment.disposition = 'attachment'
  attachment.content_id = 'Resume'
  mail.add_attachment(attachment)

  sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  response = sg.client.mail._('send').post(request_body: mail.to_json)
  puts response.status_code
  puts response.body
  puts response.headers
end 
