class CreateNewBoard102s < ActiveRecord::Migration[5.1]
  def change
    create_table :new_board102s do |t|
      t.text :content
      t.integer :user_id

      t.timestamps
    end
  end
end
