class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.string  :name
      t.belongs_to :sector
      t.integer :language_id
      t.boolean :show_login
      t.integer :belongs
      t.string :QuickRefUrl
      t.timestamps
    end
  end
end
