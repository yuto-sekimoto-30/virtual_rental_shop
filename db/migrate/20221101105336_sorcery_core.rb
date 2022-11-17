class SorceryCore < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email,            null: false, index: { unique: true }
      t.string :crypted_password
      t.string :salt
      t.string :avatar
      t.integer :role, null: false, default: 0
      t.text :introduction


      t.timestamps                null: false
    end
  end
end
