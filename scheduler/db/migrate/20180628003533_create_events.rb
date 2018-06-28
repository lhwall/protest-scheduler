class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :location
      t.date :date
      t.time :time
      t.string :description
      t.integer :user_id
      t.integer :category_id
    end
  end
end
