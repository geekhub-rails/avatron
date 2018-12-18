class CreateUserPhones < ActiveRecord::Migration[5.2]
  def change
    create_table :user_phones do |t|
      t.references :user, foreign_key: true
      t.string :number
      t.string :code
      t.string :md5_hash

      t.timestamps
    end
  end
end
