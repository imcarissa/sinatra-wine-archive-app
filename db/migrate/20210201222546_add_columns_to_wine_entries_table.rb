class AddColumnsToWineEntriesTable < ActiveRecord::Migration
  def change
    add_column :wine_entries, :wine_name, :string, {:default=>nil}
    add_column :wine_entries, :vintage, :integer, {:default=>nil}
    add_column :wine_entries, :region, :string, {:default=>nil}
    add_column :wine_entries, :wine_notes, :string, {:default=>nil}
  end
end
