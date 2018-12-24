class ConnectAvatarToPhone < ActiveRecord::Migration[5.2]
  def change
    change_table :avatars do |t|
      t.references :user_phone, foreign_key: true
    end
  end
end
