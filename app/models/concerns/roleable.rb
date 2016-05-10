module Roleable
  extend ActiveSupport::Concern

  included do
    has_one :admin_user, dependent: :destroy

    scope :admin_users,     -> { joins(:admin_users)                         }
    scope :not_admin_users, -> { where.not(id: AdminUser.select(:user_id))   }

    def make_admin
      make_user && self.create_admin_user
    end

    def make_user
      user_roles = [self.admin_user].compact
      user_roles.each do |role|
        role.destroy
      end
    end

    def admin?
      admin_user.present?
    end

    def user?
      admin_user.blank?
    end

    def role_name
      if admin?
        'Admin'
      else
        'User'
      end
    end

  end

  class_methods do
  end
end
