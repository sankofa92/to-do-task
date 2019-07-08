class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.references :task, foreign_key: true
      t.string :sort

      t.timestamps
    end
  end
end
