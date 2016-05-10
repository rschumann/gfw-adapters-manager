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
      render :edit, notice: 'User could not be updated'
    end
  end

  def deactivate
    if @user.try(:deactivate)
      redirect_to users_path, notice: 'User deactivated!'
    else
      redirect_to user_path(@user), notice: 'User could not be deactivated!'
    end
  end

  def activate
    if @user.try(:activate)
      redirect_to users_path, notice: 'User activated!'
    else
      redirect_to user_path(@user), notice: 'User could not be activated!'
    end
  end

  def make_admin
    if @user.try(:make_admin)
      redirect_to users_path, notice: 'User is admin!'
    else
      redirect_to user_path(@user), notice: 'User could not be added to admins!'
    end
  end

  def make_user
    if @user.try(:make_user)
      redirect_to users_path, notice: 'User removed from admins!'
    end
  end

  def destroy
    if @user.destroy
      redirect_to users_path, notice: 'User deleted!'
    else
      redirect_to users_path, notice: 'User could not be deleted!'
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
