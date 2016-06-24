class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :user
      t.string :level

      t.timestamps null: false
    end
  end
end
