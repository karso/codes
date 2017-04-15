require 'net/smtp'

message = <<MESSAGE_END
From: Soumitra Kar <soumitra.kar@altisource.com>
To: Rana Ghoul <ranaghoul@gmail.com>
MIME-Version: 1.0
Content-type: text/html
Subject: SMTP e-mail test

This is an e-mail message to be sent in HTML format

<b>This is HTML message.</b>
<h1>This is headline.</h1>
MESSAGE_END

Net::SMTP.start('localhost') do |smtp|
  smtp.send_message message, 'soumitra.kar@altisource.com', 
                             'ranaghoul@gmail.com'
end
