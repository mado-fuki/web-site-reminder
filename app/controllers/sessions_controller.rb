class SessionsController < ApplicationController

  def new
  end

  def create
    logger.error('params----------')
    logger.error(params)

    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      log_in user
      logger.error('ログイン-------------')
      # TODO: TOPページにリダイレクトさせる
      # redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    # redirect_to root_url
  end
end