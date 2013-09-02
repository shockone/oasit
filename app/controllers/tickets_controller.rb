class TicketsController < ApplicationController
  include ActiveModel::Dirty

  before_filter :authenticate_user!, except: [:new, :create]
  before_filter :authenticate_or_register, only: :create
  before_filter :search_by_slug_hack, only: :index

  def index
    @departments = Department.all
    @statuses = TicketStatus.all
    @search = Ticket.search(params[:q])
    @tickets = @search.result(distinct: true)

    #TODO: Optimize, it's not necessary to pull out all the tickets and then filter them.
    @tickets = @tickets.select{|ticket| ticket.reporter_id == current_user.id} unless current_user.staff?
  end


  def show
    @ticket = Ticket.find(from_param params[:id])
    @new_post = TicketPost.new
  end


  def new
    @ticket = Ticket.new
    @ticket.ticket_posts.build
    @ticket.build_reporter
  end


  def edit
    @ticket = Ticket.find(from_param params[:id])
  end


  def create
    #Add user ID to params in order to automatically create associated models
    params[:ticket][:reporter_id] = params[:ticket][:ticket_posts_attributes]['0'][:user_id] = current_user.id

    @ticket = Ticket.new(params[:ticket])
    @ticket.ticket_status_id = TicketStatus.default_status_id
    if @ticket.save
      UserMailer.ticket_created_email(@ticket).deliver
      redirect_to @ticket, notice: 'Ticket was successfully created.'
    else
      render action: 'new'
    end
  end


  def update
    @ticket = Ticket.find(from_param params[:id])

    @ticket.assign_attributes(params[:ticket])
    changes = @ticket.changes if @ticket.changed?
    if @ticket.save
      UserMailer.ticket_updated_email(@ticket, changes).deliver if changes.present?
      redirect_to @ticket, notice: 'Ticket was successfully updated.'
    else
      render action: 'edit'
    end
  end


  def destroy
    @ticket = Ticket.find(from_param params[:id])
    @ticket.destroy
  end


  private

  def search_by_slug_hack
    if params.has_key? :q and params[:q].has_key? :id_eq
      params[:q][:id_eq] = from_param(params[:q][:id_eq])
    end
  end


  def authenticate_or_register
    return true if user_signed_in?

    if User.where(email: params[:reporter][:email]).blank?
      user = create_user
      sign_in user
    else
      #TODO: Restore ticket text after user signed in
      session[:ticket] = params[:ticket]
      redirect_to new_user_session_path, {notice: 'User with this email already exists. Please sign in.'}
    end
  end


  def create_user
    params[:reporter][:password] = params[:reporter][:password_confirmation] = Devise.friendly_token.first(8)

    if (user = User.create params[:reporter])
      UserMailer.welcome_email(user).deliver
    else
      render action: 'new' and return
    end
    user
  end

  def from_param(slug)
    slug.split('-').last
  end

end
