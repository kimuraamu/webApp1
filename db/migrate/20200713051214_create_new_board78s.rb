class CreateNewBoard78s < ActiveRecord::Migration[5.1]
  def change
    create_table :new_board78s do |t|
      t.text :content
      t.integer :user_id

      t.timestamps
    end
  end
end
