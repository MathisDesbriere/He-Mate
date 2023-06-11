class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  skip_before_action :authenticate_user!, only: [:create]

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id if user_signed_in?
    authorize @comment, policy_class: CommentPolicy

    if @comment.save
      redirect_to trips_path(@comment.trip_id), flash: { success: "Comment was created successfully!" }
    else
      redirect_to trips_path(@comment.trip_id), flash: { danger: "Post was not saved" }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :content, :trip_id)
  end
end
