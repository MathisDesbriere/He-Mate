class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  skip_before_action :authenticate_user!, only: [:create]

  def create
    @comment = Comment.new(comment_params)
    @trip = Trip.find(params[:trip_id])
    @comment.trip = @trip
    @comment.user_id = current_user.id if user_signed_in?
    authorize @comment, policy_class: CommentPolicy
    respond_to do |format|
    if @comment.save
      format.html { redirect_to trips_path(@comment.trip_id) }
      format.json
    else
      format.html { render "trips/index", status: :unprocessable_entity }
      format.json
    end
  end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :trip_id)
  end
end
