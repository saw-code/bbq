class CommentsController < ApplicationController
  before_action :set_event, only: %i[create destroy]
  before_action :set_comment, only: %i[destroy]

  # POST /comments or /comments.json
  def create
    @new_comment = @event.comments.build(comment_params)
    @new_comment.user = current_user

    if @new_comment.save
      redirect_to @event, notice: t('controllers.comments.created')
    else
      render 'events/show', alert: t('controllers.comments.error')
    end
  end
end

# DELETE /comments/1 or /comments/1.json
def destroy
  message = { notice: t('controllers.comments.destroyed') }

  if current_user_can_edit?(@comment)
    @comment.destroy!
  else
    message = { alert: t('controllers.comments.error') }
  end

  redirect_to @event, message
end

private

def set_event
  @event = Event.find(params[:event_id])
end

def set_comment
  @comment = @event.comments.find(params[:id])
end

def comment_params
  params.require(:comment).permit(:body, :user_name)
end
