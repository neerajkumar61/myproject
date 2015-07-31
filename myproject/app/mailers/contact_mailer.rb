class ContactMailer < ApplicationMailer

	default to: "neerajggps@gmail.com"

  def contact_email( contact )
    @contact = contact
    mail(from: contact.email, subject: 'Contact Request')
  end

end
