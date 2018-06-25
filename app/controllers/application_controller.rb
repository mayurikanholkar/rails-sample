class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def authorize_comment
    # you have access to @commentable
    true # Your logic here
  end
end
