class AdminMailer < ApplicationMailer
  def new_post(post)
    @post = post

   	User.all.each do |user|
   	  mail(to: user.email, subject: "Nuevo Post en Fotolog")
   	end
  end
end
