class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :content
      t.string :priority
      t.string :period
      t.references :user

      t.timestamps
    end
  end
end
