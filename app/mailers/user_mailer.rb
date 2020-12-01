class UserMailer < ApplicationMailer
	default from: "feedback@stavangertk.no"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.send_feedback.subject
  #
  def send_feedback(feedback, coach)
    @feedback = feedback
    @coach = coach

    mail to: feedback.player.parent_email, subject: "Feedback fra trener", reply_to: coach.email, cc: coach.email 
  end
end
