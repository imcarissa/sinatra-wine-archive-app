class CreateWineEntries < ActiveRecord::Migration
  def change
    create_table :wine_entries do |t|
      t.string :type
      t.integer :user_id
      t.integer :vintage
      t.timestamps null: false
    end
  end
end
