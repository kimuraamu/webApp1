class CreateNewBoard85s < ActiveRecord::Migration[5.1]
  def change
    create_table :new_board85s do |t|
      t.text :content
      t.integer :user_id

      t.timestamps
    end
  end
end
