class ListMailer < ActionMailer::Base
  default from: "whatch.list@gmail.com"

  def list_email(email,yes,maybe)
    @yes = yes
    @maybe = maybe
    mail(to: email, subject: 'Your List From Whatch!')
  end
end
