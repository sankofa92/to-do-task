class TasksController < ApplicationController
  before_action :find_task, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = Task.all.order(created_at: :desc)

    # status filter
    case params[:status]
      when 'pending'  then @tasks = @tasks.where(status: 'pending').order(created_at: :desc)
      when 'doing'  then @tasks = @tasks.where(status: 'doing').order(created_at: :desc)
      when 'finish'  then @tasks = @tasks.where(status: 'finish').order(created_at: :desc)
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to root_path, notice: I18n.t('tasks.notice.create')
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
      redirect_to task_path, notice: I18n.t('tasks.notice.update')
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to root_path, notice: I18n.t('tasks.notice.destroy')
  end


  private
  def find_task
    @task = Task.find_by(id: params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :start_at, :end_at, :priority, :status)
  end
end
