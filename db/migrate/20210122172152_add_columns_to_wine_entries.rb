class AddColumnsToWineEntries < ActiveRecord::Migration
  def change
    add_column :wine_entries, :price, :integer
    add_column :wine_entries, :region, :string
  end
end
