class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  skip_before_action :authenticate_user!, only: [:create]

  def create
    @trip = Trip.find(params[:trip_id])
    @comment = Comment.new(comment_params)

    @comment.user_id = current_user.id if user_signed_in?
    authorize @comment, policy_class: CommentPolicy

    # if @comment.save
    #   redirect_to trips_path(@comment.trip_id), flash: { success: "Comment was created successfully!" }
    # else
    #   redirect_to trips_path(@comment.trip_id), flash: { danger: "Post was not saved" }
    # end
    respond_to do |format|
      if @comment.save
        format.html { redirect_to trips_path(@trip) }
        format.json
      else
        format.html { render "comments/form", status: :unprocessable_entity }
        format.json
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :trip_id)
  end
end
