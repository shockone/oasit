class TicketPostsController < ApplicationController
  # GET /ticket_posts
  # GET /ticket_posts.json
  def index
    @ticket_posts = TicketPost.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ticket_posts }
    end
  end

  # GET /ticket_posts/1
  # GET /ticket_posts/1.json
  def show
    @ticket_post = TicketPost.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ticket_post }
    end
  end

  # GET /ticket_posts/new
  # GET /ticket_posts/new.json
  def new
    @ticket_post = TicketPost.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ticket_post }
    end
  end

  # GET /ticket_posts/1/edit
  def edit
    @ticket_post = TicketPost.find(params[:id])
  end

  # POST /ticket_posts
  # POST /ticket_posts.json
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

  # PUT /ticket_posts/1
  # PUT /ticket_posts/1.json
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

  # DELETE /ticket_posts/1
  # DELETE /ticket_posts/1.json
  def destroy
    @ticket_post = TicketPost.find(params[:id])
    @ticket_post.destroy

    respond_to do |format|
      format.html { redirect_to ticket_posts_url }
      format.json { head :no_content }
    end
  end
end
