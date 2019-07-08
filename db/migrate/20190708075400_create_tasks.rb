class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.text :content
      t.string :status
      t.string :priority
      t.date :start_at
      t.date :end_at

      t.timestamps
    end
  end
end
