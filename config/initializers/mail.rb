# require "mail"

# mail = Mail.new do
#     from "sample@gmail.com" ##送信元メールアドレス
#     to "hogef8725@gmail.com" ##送信先メールアドレス
#     subject "Sample Mail from Ruby on Rails" ##メール件名
#     body "This is sample page." ##メール本文
# end

# mail.delivery_method :smtp, { address: 'smtp.gmail.com',
#     port:      587,
#     domain:    'gmail.com',
#     user_name: 'hogef8725@gmail.com',
#     password:  'gmrc jnfj ivvj xnpw'}

# mail.deliver