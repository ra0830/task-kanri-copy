class TasksController < ApplicationController
   before_action :set_task, only: [:show, :edit, :update, :destroy]
   before_action :require_logged_in

  def index

    #@tasks = Task.all.reverse_order.page(params[:page])
    @tasks = current_user.tasks

    # 並び替え
    if params[:sample].present? || params[:sample] == 'true'
      @tasks = @tasks.order(:period).page(params[:page])
    elsif params[:fast].present? || params[:fast] == 'true'
      @tasks = @tasks.order(:priority).page(params[:page])
    else
      @tasks = @tasks.all.reverse_order.page(params[:page])
    end

    #タイトル検索
    if params[:search].present?
      @tasks = @tasks.search(params[:search], params[:page])
    end

    #状態検索
    if params[:task].present? && params[:task][:search_status].present?
      @tasks = @tasks.search_status(params[:task][:search_status], params[:task][:status], params[:page])
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
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

  def require_logged_in
    redirect_to new_session_path, notice: t("layout.session.require_login") unless logged_in?
  end

end
