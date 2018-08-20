class UserMailer < ApplicationMailer
    default from: "demo@workflow.com"

    def welcome_email(user)
        @ur = user
        mail(to: @ur.email, subject: "Hello", content_type: "text/html")
    end
end
