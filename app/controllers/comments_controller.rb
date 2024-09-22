# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = Comments::Create::Service.new(params[:project_id], comment_params).call
    @project = @comment.project
  rescue ActiveModel::ValidationError
    flash.now[:error] = 'Failed to add a comment.'
    # render turbo_stream: turbo_stream.replace("flash", partial: "shared/flash_messages")
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
