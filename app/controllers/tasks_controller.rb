class TasksController < ApplicationController
  def index
  	if current_user
  		@complete = current_user.tasks.where(complete: true)
  		@incomplete = current_user.tasks.where(complete: false)
  	end
  end

  def create
  	@task = current_user.tasks.build(task_params)
  	if @task.save
  		redirect_to tasks_path, notice: "Task added successfully"
  	else
  		flash.now[:error] = "Task failed to be added."
  		render 'new'
  	end
  end

  def update
  	@task = Task.find(params[:id])
  	@task.update_attributes(task_params)

  	respond_to do |format|
  		format.html { redirect_to tasks_path }
  		format.js
  	end
  end

  def destroy
  	@task = Task.find(params[:id])
  	@task.destroy
  	
  	respond_to do |format|
  		format.html { redirect_to tasks_path }
  		format.js
  	end
  end

  private

  	def task_params
  		params.require(:task).permit(:content, :complete)
  	end
end
