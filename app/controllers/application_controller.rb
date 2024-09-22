# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_response

  private

  def record_not_found_response(exception)
    redirect_to :root, flash: { error: exception.message }
  end
end
