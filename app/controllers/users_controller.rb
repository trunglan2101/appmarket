class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  PER_PAGE = 2
  def index
    page = params[:page].nil? ? 1 : params[:page].to_i
    @paginate = (page - 1)*PER_PAGE
    @users = User.paginate(page: params[:page], per_page: PER_PAGE).order("created_at desc")
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    respond_to do |format|
      if current_user.update(user_params)
        format.html {redirect_to current_user, notice:"You successfully updated your profile!!"}
      else
        format.html {render :edit}
      end
    end
  end

  private
  def user_params
    params.require(:user).permit(:avatar, :name, :email, :admin, :address)
  end
end
