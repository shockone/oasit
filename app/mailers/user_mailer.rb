class UserMailer < ActionMailer::Base
  default from: 'noreply@oasit.herokuapp.com'

  def welcome_email(user)
    @user = user
    @url  = 'http://oasit.herokuapp.com/users/sign_in'
    mail(to: @user.email, subject: 'Welcome to Oasit')
  end

  def ticket_created_email(ticket)
    @user = ticket.reporter
    @url = url_for ticket
    mail(to: @user.email, subject: 'Your ticket has been created')
  end

  def ticket_updated_email(ticket, changes)
    @user = ticket.reporter
    @url = url_for ticket

    @changes = []

    if changes[:department_id].present?
      @changes << "The ticket was moved to the #{Department.find(changes[:department_id]).first.title} department."
    end

    if changes[:ticket_status_id].present?
      @changes << "The status of the ticket is now \"#{TicketStatus.find(changes[:ticket_status_id]).first.name}\"."
    end

    if changes[:employee_id].present?
      @changes << "Your personal support manager is \"#{User.find(changes[:employee_id]).first.name}\"."
    end

    mail(to: @user.email, subject: 'Your ticket has been updated')
  end

  def post_created_email(user, ticket_post)
    @user = user
    @ticket_post = ticket_post
    @url = url_for @ticket_post.ticket

    mail(to: @user.email, subject: 'You received an answer to your ticket')
  end
end
