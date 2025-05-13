class CreateStudentCourseEntrollments < ActiveRecord::Migration[7.1]
  def change
    create_table :student_course_entrollments do |t|
      t.belongs_to :user
      t.belongs_to :course
      t.string :status
      t.integer :percentage
      t.boolean :unlock, :default => 0
      t.integer :score
      t.timestamps
    end
  end
end
