class ApplicationController < ActionController::Base
  before_action :set_current_user

  def set_current_user
    # find：見つからなかった場合エラーが返ってくる
    # https://qiita.com/tsuchinoko_run/items/f3926caaec461cfa1ca3
    # sessionリファレンス
    # http://railsdoc.com/references/session
    @current_user = User.find_by(id: session[:user_id])
  end

  def authenticate_user
    # 非ログイン時のアクセス制限
    if @current_user == nil
      flash[:notice] = "ログインが必要です"
      redirect_to("/login")
    end
  end

  def forbid_login_user
    if @current_user
      flash[:notice] = "すでにログインしています"
      redirect_to "/posts/index"
    end
  end

end
