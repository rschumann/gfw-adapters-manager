class UsersController < AuthController
  before_action :set_user, except: :index
  before_action :user_filters, only: :index

  load_and_authorize_resource

  def index
    @users = User.filter_users(user_filters) if current_user && current_user.admin?
  end

  def edit_info
  end

  def update_info
    if @user.update(user_params)
      redirect_to users_path, notice: 'User updated'
    else
      render :edit
    end
  end

  def deactivate
    if @user.try(:deactivate)
      redirect_to users_path
    else
      redirect_to user_path(@user)
    end
  end

  def activate
    if @user.try(:activate)
      redirect_to users_path
    else
      redirect_to user_path(@user)
    end
  end

  def make_admin
    if @user.try(:make_admin)
      redirect_to users_path
    end
  end

  def make_user
    if @user.try(:make_user)
      redirect_to users_path
    end
  end

  private

    def user_filters
      params.permit(:active)
    end

    def set_user
      user_id = params[:id] || params[:user_id]
      @user   = User.find(user_id)
    end

    def user_params
      params.require(:user).permit!
    end
end
