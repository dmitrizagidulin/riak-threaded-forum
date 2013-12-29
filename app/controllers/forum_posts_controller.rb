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
    @forum = Forum.find(@forum_post.forum_key)
    @author_name = @forum_post.username
  end

  # GET /forums/456/discussions/789/posts/123/reply
  def new_reply_post
    @reply_to_post = ForumPost.find(params[:reply_to_post])
    @forum = Forum.find(@reply_to_post.forum_key)
    @discussion = Discussion.find(params[:discussion_key])
    @current_user = current_user
    @forum_post = ForumPost.reply_to(@reply_to_post, @current_user)
  end
  
  # GET /forums/456/discussions/789/reply
  def new_reply_discussion
    @discussion = Discussion.find(params[:discussion_key])
    @forum = Forum.find(@discussion.forum_key)
    @current_user = current_user
    @forum_post = ForumPost.reply_to_discussion(new_post_params={}, @discussion, @current_user)
  end
  
  # GET /forum_posts/1/edit
  def edit
    @forum = Forum.find(@forum_post.forum_key)
    @current_user = current_user
  end

  # POST /forums/456/discussions/
  def create_discussion
    reply_to_post_key = params[:forum_post][:reply_to_post]
    discussion_key = params[:forum_post][:discussion_key]
    @forum = Forum.find(params[:forum_post][:forum_key])
    if reply_to_post_key.present?
      # A reply to an existing post
      @reply_to_post = ForumPost.find(reply_to_post_key)
      @discussion = Discussion.find(@reply_to_post.discussion_key)
      @forum_post = ForumPost.reply_to(@reply_to_post, current_user, new_reply_params)
    elsif discussion_key.present?
      # A reply to an existing discussion
      @discussion = Discussion.find(discussion_key)
      @forum_post = ForumPost.reply_to_discussion(new_reply_params, @discussion, current_user)
    else
      # Not a reply, but start of a new discussion
      @discussion = Discussion.new_from_post(new_post_params, current_user, @forum)
      @forum_post = @discussion.initial_post
      @discussion.save!
    end

    respond_to do |format|
      if @forum_post.save
        redirect_url = "/forums/#{@forum.key}/discussions/#{@discussion.key}##{@forum_post.key}"
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
  def create
    puts "In create, params:"
    puts params[:forum_post]
    reply_to_post_key = params[:forum_post][:reply_to_post]
    discussion_key = params[:forum_post][:discussion_key]
    @forum = Forum.find(params[:forum_post][:forum_key])
    if reply_to_post_key.present?
      # A reply to an existing post
      @reply_to_post = ForumPost.find(reply_to_post_key)
      @discussion = Discussion.find(@reply_to_post.discussion_key)
      @forum_post = ForumPost.reply_to(@reply_to_post, current_user, new_reply_params)
    elsif discussion_key.present?
      # A reply to an existing discussion
      @discussion = Discussion.find(discussion_key)
      @forum_post = ForumPost.reply_to_discussion(new_reply_params, @discussion, current_user)
    else
      # Not a reply, but start of a new discussion
      @discussion = Discussion.new_from_post(new_post_params, current_user, @forum)
      @forum_post = @discussion.initial_post
      @discussion.save!
    end

    respond_to do |format|
      if @forum_post.save
        redirect_url = "/forums/#{@forum.key}/discussions/#{@discussion.key}##{@forum_post.key}"
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
      params[:forum_post].permit(:forum_key, :name, :body)
    end
    
    def new_reply_params
      params[:forum_post].permit(:reply_to_post, :name, :body)
    end
    
    def update_params
      params[:forum_post].permit(:name, :body)
    end
end
