require 'rails_helper'

RSpec.describe User, type: :model do
  context 'For users' do
    before :each do
      @user = create(:user, active: true)
      @user_deactivated = create(:user, active: false)
    end

    it 'Users count' do
      expect(User.count).to eq(2)
    end

    it 'Deactivate activate user' do
      @user.deactivate
      expect(User.count).to eq(2)
      expect(User.filter_inactives.count).to eq(2)
      expect(@user.deactivated?).to be(true)
    end

    it 'Activate user' do
      @user_deactivated.activate
      expect(User.filter_actives.count).to be(2)
      expect(@user_deactivated.activated?).to be(true)
    end
  end

  context 'For admins' do
    before :each do
      @user       = create(:user)
      @admin_user = create(:admin_user)
    end

    it 'Make user admin' do
      @user.make_admin
      expect(AdminUser.count).to eq(2)
    end

    it 'Remove user from admins' do
      @admin_user.make_user
      expect(AdminUser.count).to eq(0)
    end
  end
end
