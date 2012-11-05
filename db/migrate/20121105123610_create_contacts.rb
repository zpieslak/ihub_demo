class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.integer :user_id
      t.integer :group_id

      t.timestamps
    end

    add_index :contacts, :user_id
    add_index :contacts, :group_id
  end
end
