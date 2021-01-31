class CreateWineEntriesTable < ActiveRecord::Migration
  def change
    create_table :wine_entries do |t|
      t.string :wine_type
      t.integer :user_id
      t.timestamps null: false
    end
  end
end