class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login

  def not_authenticated
    redirect_to :login
  end

  def requires_admin
    if !current_user.is_admin
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end
