class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.datetime :start_at
      t.datetime :end_at
      t.string :address
      t.string :slug
      t.timestamps
    end
    add_index :events, :slug, unique: true
  end
end
