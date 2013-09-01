class TicketsController < ApplicationController

  before_filter :authenticate_user!, except: [:new, :create]
  before_filter :authenticate_or_register, only: :create

  def index
    @departments = Department.all
    @statuses = TicketStatus.all
    @search = Ticket.search(params[:q])
    @tickets = @search.result

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tickets }
    end
  end


  def show
    @ticket = Ticket.find(params[:id])
    @new_post = TicketPost.new

    respond_to do |format|
      format.html
      format.json { render json: @ticket }
    end
  end


  def new
    @ticket = Ticket.new
    @ticket.ticket_posts.build
    @ticket.build_reporter

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ticket }
    end
  end


  def edit
    @ticket = Ticket.find(params[:id])
  end


  def create
    params[:ticket][:reporter_id] = params[:ticket][:ticket_posts_attributes]['0'][:user_id] = current_user.id

    @ticket = Ticket.new(params[:ticket])
    @ticket.ticket_status_id = TicketStatus.default_status_id
    respond_to do |format|
      if @ticket.save
        UserMailer.welcome_email(@ticket.reporter).deliver
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.json { render json: @ticket, status: :created, location: @ticket }
      else
        format.html { render action: 'new' }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      if @ticket.update_attributes(params[:ticket])
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to tickets_url }
      format.json { head :no_content }
    end
  end

  private

  def authenticate_or_register
    return true if user_signed_in?

    if User.where(email: params[:reporter][:email]).blank?
      user = create_user
      sign_in user
    else
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
end
