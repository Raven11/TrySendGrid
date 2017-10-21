 #using SendGrid's Ruby Library
 # https://github.com/sendgrid/sendgrid-ruby
 require 'sendgrid-ruby'
 require 'csv'
 include SendGrid


 CSV.foreach("../GRA.csv") do |row|
 
 from = Email.new(email: 'ebairagi1@student.gsu.edu')
 to = Email.new(email: "#{row[0]}")
 subject = 'GRA opportunities'
 content = Content.new(type: 'text/plain', 
                       value: "Hello Professor #{row[1]},
                       
                       Hope you are doing great today.
                       I am a Graduate Student, pursuing my masters in information systems in GSU.
                       I am writing this email to check if any GRA position 
                       opened up with you for spring semester.
                       Kindly Let me know of you need any information from my side to proceed further.
                        
                       
                       Thanks and Regards,
                       Eshan Bairagi
                       +1 (470) 399-3215                          
                       https://www.linkedin.com/in/eshan-bairagi-2675a4b/")
 mail = Mail.new(from, subject, to, content)

 sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
 response = sg.client.mail._('send').post(request_body: mail.to_json)
 puts response.status_code
 puts response.body
 puts response.headers
 end 
