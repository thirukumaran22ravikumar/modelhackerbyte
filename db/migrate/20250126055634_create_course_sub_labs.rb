class CreateCourseSubLabs < ActiveRecord::Migration[7.1]
  def change
    create_table :course_sub_labs do |t|
      t.string :name
      t.belongs_to :course_lab
      t.text :sub_lab_data
      t.text :sub_lab_initial_code
      t.text  :correct_option
      t.text :embedded_url
      t.string :lab_type
      t.boolean :show_url
      t.timestamps
    end
  end
end
