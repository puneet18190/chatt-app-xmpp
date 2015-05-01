class AddUserNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :chat_name, :string
  end
end
