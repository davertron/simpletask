class TasksController < ApplicationController
  before_filter :require_login

  def index
    @tasks = Task.where :user_id => current_user.id
    @task = Task.new
    @showArchived = if params[:show_archived] then true else false end

    respond_to do |format|
      format.html
      format.json { render :json => @tasks.to_json(:methods => :duration_in_words) }
    end
  end

  def create
    # Tack our user id on there
    params[:task][:user_id] = current_user.id
    if @task = Task.create(params[:task])
      respond_to do |format|
        format.html { 
          redirect_to tasks_url 
        }

        format.json {
          render :json => @task
        }
      end
    else
      respond_to do |format|
        format.html { 
          redirect_to new_task_url
        }

        format.json {
          head :bad_request
        }
      end
    end
  end

  def show
    @task = Task.find params[:id]

    respond_to do |format|
      format.html
      format.json { render :json => @task.to_json }
    end
  end

  def destroy
    if Task.destroy params[:id]
      respond_to do |format|
        format.html { 
          redirect_to tasks_url 
        }

        format.json {
          head :ok
        }
      end
    else
      respond_to do |format|
        format.html { 
          redirect_to task_url(params[:id])
        }

        format.json {
          head :bad_request
        }
      end
    end
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(params[:task])
      respond_to do |format|
        format.html {
          redirect_to @task
        }

        format.json {
          head :ok
        }
      end
    else
      respond_to do |format|
        format.html {
          redirect_to @task
        }

        format.json {
          head :bad_request
        }
      end
    end
  end
end
