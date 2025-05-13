class CreateCourseLabs < ActiveRecord::Migration[7.1]
  def change
    create_table :course_labs do |t|
      t.string :name 
      t.belongs_to :course
      t.integer :language_id
      t.boolean :show_login
      t.text :description
      t.integer :lab_point
      t.string :difficulty_level
      t.integer :order
      t.timestamps
    end
  end
end
