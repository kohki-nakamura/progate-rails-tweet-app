class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:index, :show, :edit, :update]}
  before_action :forbid_login_user, {only: [:new, :create, :login, :login_form]}
  before_action :ensure_correct_user, {only: [:edit, :update]}

  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to "/posts/index"
    else
      @email = params[:email]
      @password = params[:password]
      flash[:notice] = "ログインに失敗しました"
      @error_message = "メールアドレスまたはパスワードが間違っています"
      render "users/login_form"
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to "/login"
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(name: params[:name], email: params[:email], image_name: "default_user.png", password: params[:password])
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to "/users/#{@user.id}"
    else
      render "users/new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    if params[:image]
      @user.image_name = "#{@user.id}.png"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end
    if @user.save
      flash[:notice] = "ユーザー情報を更新しました"
      redirect_to "/users/index"
    else
      render "users/edit"
    end
  end

  def likes
    @user = User.find(params[:id])
  end

  def ensure_correct_user
    @user = User.find_by(id: params[:id])
    if @current_user.id != @user.id
      flash[:notice] = "権限がありません"
      redirect_to "/posts/index"
    end
  end

end
