class Admin::UsersController < ApplicationController
  before_filter :requires_admin

  def index
    @users = User.paginate(:page => params[:page])
  end

  def show
    @showArchived = false
    @user = User.find(params[:id])
    @task = Task.new
    if @user
      @tasks = @user.tasks
    end

    render "/tasks/index"
  end
end
