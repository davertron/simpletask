class Admin::DashboardController < ApplicationController
  before_filter :requires_admin

  def index
    @stats = {
      :user_count => User.all.size,
      :task_count => Task.all.size,
      :time_entry_count => Task.all.reduce(0){ |sum, t| sum + t.time_entries.size }
    }
  end
end
