class TimeEntriesController < ApplicationController
  def index
    @time_entries = Task.find(params[:task_id]).time_entries

    respond_to do |format|
      format.html
      format.json { render :json => @time_entries.to_json }
    end
  end
end
