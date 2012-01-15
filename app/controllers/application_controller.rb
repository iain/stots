class ApplicationController < ActionController::Base
  protect_from_forgery

  def projects
    @projects ||= Project.all
  end
  helper_method :projects

end
