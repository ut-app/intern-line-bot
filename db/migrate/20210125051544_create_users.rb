class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :user_id, :null => false

      t.timestamps
    end

    add_index :users, [:user_id], unique: true
  end
end
