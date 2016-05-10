class User < ApplicationRecord
  include Activable
  include Roleable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, authentication_keys: [:login]

  attr_accessor :login

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validate  :validate_username

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["username = :value OR email = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_hash).first
    end
  end

   def self.filter_users(filters)
    actives   = filters[:active]['true']  if filters[:active].present?
    inactives = filters[:active]['false'] if filters[:active].present?

    users = if actives.present?
              filter_actives
            elsif inactives.present?
              filter_inactives
            else
              all
            end
    users
  end

  def full_name
    "#{firstname} #{lastname}"
  end

  def full_name_or_username
    if firstname.present? || lastname.present?
      "#{firstname} #{lastname}"
    else
      username
    end
  end

  private

    def validate_username
      if User.where(email: username).exists?
        errors.add(:username, :invalid)
      end
    end
end
