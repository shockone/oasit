class TicketPostsController < ApplicationController

  def index
    @ticket_posts = TicketPost.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ticket_posts }
    end
  end


  def show
    @ticket_post = TicketPost.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ticket_post }
    end
  end


  def new
    @ticket_post = TicketPost.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ticket_post }
    end
  end


  def edit
    @ticket_post = TicketPost.find(params[:id])
  end


  def create
    @ticket_post = TicketPost.new(params[:ticket_post])

    respond_to do |format|
      if @ticket_post.save
        format.html { redirect_to :back, notice: 'Reply was successfully created.' }
        format.json { render json: @ticket_post, status: :created, location: @ticket_post }
      else
        format.html { render action: "new" }
        format.json { render json: @ticket_post.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @ticket_post = TicketPost.find(params[:id])

    respond_to do |format|
      if @ticket_post.update_attributes(params[:ticket_post])
        format.html { redirect_to @ticket_post, notice: 'Ticket post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ticket_post.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @ticket_post = TicketPost.find(params[:id])
    @ticket_post.destroy

    respond_to do |format|
      format.html { redirect_to ticket_posts_url }
      format.json { head :no_content }
    end
  end
end
