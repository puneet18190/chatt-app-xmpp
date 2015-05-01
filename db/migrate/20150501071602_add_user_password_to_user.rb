class AddUserPasswordToUser < ActiveRecord::Migration
  def change
    add_column :users, :user_password, :string
  end
end
