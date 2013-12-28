class DiscussionsController < ApplicationController
  before_action :require_user, only: [:index]  # Require login
  before_action :set_discussion, only: [:show]

  # GET /discussions
  # GET /discussions.json
  def index
    @discussions = Discussion.all
  end

  # GET /discussions/1
  # GET /discussions/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discussion
      @discussion = Discussion.find(params[:id])
    end
end
