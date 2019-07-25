class TasksController < ApplicationController
  before_action :find_task, only: [:show, :edit, :update, :destroy, :take, :drop]
  def index
    @q = Task.ransack(params[:q])
    @tasks = @q.result.order(created_at: :desc).page(params[:page]).per(8)

    # status filter
    case params[:status]
      when 'pending'  then @tasks = @tasks.where(status: 'pending')
      when 'doing'  then @tasks = @tasks.where(status: 'doing')
      when 'finish'  then @tasks = @tasks.where(status: 'finish')
    end
  end

  def search
    render :index
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user = User.find_by(id: 1)
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

  def take
    @task.take!
    redirect_back(fallback_location: root_path, notice: I18n.t('tasks.notice.take'))
    
  end
  
  def drop
    @task.drop!
    redirect_back(fallback_location: root_path, notice: I18n.t('tasks.notice.drop'))
    
  end

  private
  def find_task
    @task = Task.find_by(id: params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :end_at, :priority)
  end
end
