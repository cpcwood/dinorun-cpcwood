# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_login, :assign_user

  # callback to set CSRF TOKEN for non-idempotent ajax request
  after_action :add_csrf_token_to_json_request_header

  private

  def require_login
    render(nothing: true, status: 403) unless session[:user_id]
  end

  def assign_user
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
      unless @user
        reset_session
        redirect_to('/')
      end
    end
  end

  def add_csrf_token_to_json_request_header
    if request.xhr? && !request.get? && protect_against_forgery?
      response.headers['X-CSRF-Token'] = form_authenticity_token
    end
  end
end
