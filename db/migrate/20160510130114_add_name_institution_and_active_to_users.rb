class AddNameInstitutionAndActiveToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :institution, :string
    add_column :users, :active, :boolean, default: false, null: false
    add_column :users, :deactivated_at, :datetime
  end
end
