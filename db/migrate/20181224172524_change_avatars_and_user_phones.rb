class ChangeAvatarsAndUserPhones < ActiveRecord::Migration[5.2]
  def change
    add_column :user_phones, :avatar_id, :integer, foreign_key: true
    remove_column :avatars, :user_phone_id, :integer
  end
end
