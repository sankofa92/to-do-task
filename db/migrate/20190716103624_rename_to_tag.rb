class RenameToTag < ActiveRecord::Migration[5.2]
  def change
    rename_column :tags, :sort, :name
  end
end
