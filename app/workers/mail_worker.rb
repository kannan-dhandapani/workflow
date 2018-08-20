class MailWorker < UserMailer
    include Sidekiq::Worker
    def perform(user)
        welcome_email(user)
    end
end