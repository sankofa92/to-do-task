class TasksController < ApplicationController
  before_action :find_task, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to root_path, notice: '新增成功'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to task_path, notice: '修改成功'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to root_path, notice: '刪除成功'
  end

  # status filter
  def pending
    @tasks = Task.where("status = ?",'待處理')
  end

  def doing
    @tasks = Task.where("status = ?",'進行中')
  end

  def finish
    @tasks = Task.where("status = ?",'已完成')
  end

  private
  def find_task
    @task = Task.find_by(id: params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :start_at, :end_at, :priority, :status)
  end
end
