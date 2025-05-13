class CreateCourseTittles < ActiveRecord::Migration[7.1]
  def change
    create_table :course_tittles do |t|
      t.string :name
      t.belongs_to :sector
      t.boolean :show_login
      t.json  :select_course
      t.integer :belongs
      t.timestamps
    end
  end
end
