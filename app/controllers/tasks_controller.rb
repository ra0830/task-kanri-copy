class TasksController < ApplicationController
   before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index

    @tasks = Task.all.reverse_order
    #@tasks = Task.page(params[:page])

  #   # 並び替え
    if params[:sample].present? || params[:sample] == 'true'
      @tasks = Task.order(:period)
    elsif params[:fast].present? || params[:fast] == 'true'
      @tasks = Task.order(:priority)
    else
      @tasks = Task.all.reverse_order
      #@tasks = Task.page(params[:page])
    end
    #タイトル検索
    if params[:search].present?
      @tasks = Task.search(params[:search])
    end
    #状態検索
    # if params[:task].present? && params[:task][:search_status] == 'true'
    #   #@tasks = Task.where(['status LIKE ?', "%#{status}%"])
    #   @tasks = Task.where(status: params[:task][:status])
    # else
    #   @tasks = Task.all.reverse_order
    # end
    #状態検索（form_with使用、モデルに分散）
    if params[:search_status].present?
      @tasks = Task.search_status(params[:search_status])
    end

  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "タスクを作成しました！"
    else
      render 'new'
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました！"
  end

  private

  def task_params
    params.require(:task).permit(:title,:content,:period,:sample,:status,:search,:priority,:fast,:search_status)
  end

  def set_task
    @task = Task.find(params[:id])
  end

end
