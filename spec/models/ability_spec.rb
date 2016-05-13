require 'rails_helper'

RSpec.describe Ability, type: :model do
  before :each do
    @admin_user = create(:admin_user, active: true)
    @user       = create(:user, active: true)
  end

  it { Abilities::AdminUser.should include(CanCan::Ability) }
  it { Abilities::AdminUser.should respond_to(:new).with(1).argument }

  it { Abilities::User.should include(CanCan::Ability) }
  it { Abilities::User.should respond_to(:new).with(1).argument }

  it { Abilities::Guest.should include(CanCan::Ability) }
  it { Abilities::Guest.should respond_to(:new).with(1).argument }

  context 'admin' do
    it 'can manage objects' do
      Abilities::AdminUser.any_instance.should_receive(:can).with(:manage, User)
      Abilities::AdminUser.any_instance.should_receive(:can).with([:edit_info, :update_info], User)
      Abilities::AdminUser.any_instance.should_receive(:cannot).with(:make_user, User, id: @admin_user.id)
      Abilities::AdminUser.any_instance.should_receive(:cannot).with([:activate, :deactivate], User, id: @admin_user.id)

      Abilities::AdminUser.any_instance.should_receive(:can).with(:read, :all)
      Abilities::AdminUser.new @admin_user
    end
  end

  context 'user' do
    it 'can manage objects' do
      Abilities::User.any_instance.should_receive(:can).with(:manage, User, id: @user.id)
      Abilities::User.any_instance.should_receive(:cannot).with(:read, User)
      Abilities::User.any_instance.should_receive(:can).with(:read, :all)
      Abilities::User.new @user
    end
  end

  context 'guest' do
    it 'can read objects' do
      Abilities::Guest.new @user
    end
  end
end
