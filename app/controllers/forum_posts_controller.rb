class ForumPostsController < ApplicationController
  before_action :require_user, except: [:show]  # Require login
  before_action :set_forum_post, only: [:show, :edit, :update, :destroy]

  # GET /forum_posts
  # GET /forum_posts.json
  def index
    @forum_posts = ForumPost.all
  end

  # GET /forum_posts/1
  # GET /forums/456/discussions/789/posts/1
  # GET /forum_posts/1.json
  def show
    @discussion = Discussion.find(params[:discussion_id])
    @forum = Forum.find(@forum_post.forum_key)
    @author_name = @forum_post.username
  end

  # GET /forums/456/discussions/789/posts/123/reply
  # Loads New Reply to Post form
  def reply
    @reply_to_post = ForumPost.find(params[:reply_to_post])
    @forum = Forum.find(@reply_to_post.forum_key)
    @discussion = Discussion.find(params[:discussion_id])
    @current_user = current_user
    @forum_post = ForumPost.reply_to(@reply_to_post, @current_user)
  end
  
  # GET /discussions/789/forum_posts/new
  # Loads New Reply to Discussion form
  def new
    @discussion = Discussion.find(params[:discussion_id])
    @forum = Forum.find(@discussion.forum_key)
    @current_user = current_user
    @forum_post = ForumPost.reply_to_discussion(new_post_params={}, @discussion, @current_user)
  end
  
  # GET /forum_posts/1/edit
  def edit
    @forum = Forum.find(@forum_post.forum_key)
    @current_user = current_user
  end
  
  # POST /forum_posts
  # POST /forum_posts.json
  # Creates a new Reply to a Discussion
  def create
    @discussion = Discussion.find(params[:discussion_id])
    @forum = Forum.find(@discussion.forum_key)
    @forum_post = ForumPost.reply_to_discussion(new_post_params, @discussion, current_user)

    respond_to do |format|
      if @forum_post.save
        redirect_url = "/discussions/#{@discussion.key}/##{@forum_post.key}"
        format.html { redirect_to redirect_url, notice: 'Forum post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @forum_post }
      else
        format.html { render action: 'new' }
        format.json { render json: @forum_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /forum_posts
  # POST /forum_posts.json
  # Creates a new Reply to a Post
  def create_reply
    @discussion = Discussion.find(params[:discussion_id])
    @forum = Forum.find(@discussion.forum_key)
    @reply_to_post = ForumPost.find(params[:forum_post][:reply_to_post])
    @current_user = current_user
    @forum_post = ForumPost.reply_to(@reply_to_post, @current_user, new_reply_params)

    respond_to do |format|
      if @forum_post.save
        redirect_url = "/discussions/#{@discussion.key}/##{@forum_post.key}"
        format.html { redirect_to redirect_url, notice: 'Forum post was successfully created.' }
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
      params[:forum_post].permit(:name, :body)
    end
    
    def new_reply_params
      params[:forum_post].permit(:reply_to_post, :name, :body)
    end
    
    def update_params
      params[:forum_post].permit(:name, :body)
    end
end
