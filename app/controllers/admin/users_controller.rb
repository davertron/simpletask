class Admin::UsersController < ApplicationController
  before_filter :requires_admin

  def index
    @users = User.paginate(:page => params[:page])
  end
end
