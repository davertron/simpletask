class TasksController < ApplicationController
  def index
    @tasks = Task.all
    @task = Task.new

    respond_to do |format|
      format.html
      format.json { render :json => @tasks.to_json(:methods => :duration_in_words) }
    end
  end

  def create
    if @task = Task.create(params[:task])
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
          redirect_to new_task_url
        }

        format.json {
          head :bad_request
        }
      end
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
end
