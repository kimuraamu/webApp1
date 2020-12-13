class UserNotifierMailer < ApplicationMailer
    default :from => "sample@gmail.com"
    def send_signup_email
        @greeting = "Hi"
        mail( :to => "sample@gmail.com", :subject => "新規登録が完了しました。" )
    end
end
