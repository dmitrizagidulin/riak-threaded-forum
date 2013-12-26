class ForumPostsController < ApplicationController
  before_action :require_user, only: [:new, :edit, :update, :destroy, :reply]  # Require login
  before_action :set_forum_post, only: [:show, :edit, :update, :destroy]

  # GET /forum_posts
  # GET /forum_posts.json
  def index
    @forum_posts = ForumPost.all
  end

  # GET /forum_posts/1
  # GET /forums/456/posts/1
  # GET /forum_posts/1.json
  def show
    @forum = Forum.find(@forum_post.forum_key)
    @author_name = @forum_post.username
  end

  # GET /forum_posts/new
  # GET /forums/456/posts/new
  def new
    @forum_post = ForumPost.new
    @forum = Forum.find(params[:forum_key])
    @current_user = current_user
  end

  # GET /forums/456/posts/123/reply
  def reply
    @reply_to_post = ForumPost.find(params[:reply_to_post])
    @current_user = current_user
    @forum_post = ForumPost.reply_to(@reply_to_post, @current_user)
    @forum = Forum.find(@reply_to_post.forum_key)
  end
  
  # GET /forum_posts/1/edit
  def edit
    @forum = Forum.find(@forum_post.forum_key)
    @current_user = current_user
  end

  # POST /forum_posts
  # POST /forum_posts.json
  def create
    reply_to_post_key = params[:forum_post][:reply_to_post]
    if reply_to_post_key.present?
      @reply_to_post = ForumPost.find(reply_to_post_key)
      @forum_post = ForumPost.reply_to(@reply_to_post, current_user, new_reply_params)
    else
      @forum_post = ForumPost.new(new_post_params)
      @forum_post.created_by = current_user.key
    end

    respond_to do |format|
      if @forum_post.save
        format.html { redirect_to @forum_post, notice: 'Forum post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @forum_post }
      else
        format.html { render action: 'new' }
        format.json { render json: @forum_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /forum_posts/1
  # PATCH/PUT /forum_posts/1.json
  def update
    respond_to do |format|
      if @forum_post.update(update_params)
        format.html { redirect_to @forum_post, notice: 'Forum post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @forum_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forum_posts/1
  # DELETE /forum_posts/1.json
  def destroy
    @forum_post.destroy
    respond_to do |format|
      format.html { redirect_to forum_posts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_forum_post
      @forum_post = ForumPost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def new_post_params
      params[:forum_post].permit(:forum_key, :name, :body)
    end
    
    def new_reply_params
      params[:forum_post].permit(:reply_to_post, :name, :body)
    end
    
    def update_params
      params[:forum_post].permit(:name, :body)
    end
end
