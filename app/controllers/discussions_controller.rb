class DiscussionsController < ApplicationController
  before_action :require_user, only: [:index]  # Require login
  before_action :set_discussion, only: [:show]
  before_action :set_forum, only: [:show]

  # GET /discussions
  # GET /discussions.json
  def index
    @discussions = Discussion.all
  end

  # GET /discussions/1
  # GET /discussions/1.json
  def show
    @posts = @discussion.all_posts
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discussion
      @discussion = Discussion.find(params[:id])
    end
    
    def set_forum
      @forum = Forum.find(params[:forum_key])
    end
end
