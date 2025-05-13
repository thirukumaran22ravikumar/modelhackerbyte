class CreateCourseEntrolls < ActiveRecord::Migration[7.1]
  def change
    create_table :course_entrolls do |t|
      t.belongs_to :user
      t.belongs_to :course
      t.timestamps
    end
  end
end
