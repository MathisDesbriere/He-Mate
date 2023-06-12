if @comment.persisted?
  json.form render(partial: "comments/form", formats: :html, locals: { trip: @trip, comment: Comment.new })
  json.inserted_item render(partial: "comments/comment", formats: :html, locals: { comment: @comment })
else
  json.form render(partial: "comments/form", formats: :html, locals: { trip: @trip, comment: @comment })
end
