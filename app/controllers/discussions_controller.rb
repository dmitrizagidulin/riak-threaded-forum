class DiscussionsController < ApplicationController
  before_action :require_user, only: [:index, :new, :create]  # Require login
  before_action :set_discussion, only: [:show]

  # POST /forums/123/discussions
  def create
    @forum = Forum.find(params[:forum_id])
    @discussion = Discussion.new_from_post(new_post_params, current_user, @forum)
    @forum_post = @discussion.initial_post
    @discussion.save!

    respond_to do |format|
      if @forum_post.save
        redirect_url = "/forums/#{@forum.key}/##{@forum_post.key}"
        format.html { redirect_to url_for([@forum, @discussion]), notice: 'Discussion created.' }
        format.json { render action: 'show', status: :created, location: @forum_post }
      else
        format.html { render action: 'new' }
        format.json { render json: @forum_post.errors, status: :unprocessable_entity }
      end
    end
  end
    
  # GET /discussions
  # GET /discussions.json
  def index
    @discussions = Discussion.all
  end

  def new
    @forum = Forum.find(params[:forum_id])
    @current_user = current_user
    @forum_post = ForumPost.new
  end
  
  # GET /discussions/1
  # GET /discussions/1.json
  def show
    @forum = Forum.find(@discussion.forum_key)
    @posts = @discussion.all_posts
    @posts_hash = {}
    @top_level_replies = []
    @posts.each { | p | @posts_hash[p.key] = p }
    @posts.map do | p |
      if p.top_level_reply?
        @top_level_replies << p
      else
        parent = @posts_hash[p.reply_to]
        parent.replies << p.key
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def new_post_params
      params[:forum_post].permit(:name, :body)
    end
  
    def set_discussion
      @discussion = Discussion.find(params[:id])
    end
end
