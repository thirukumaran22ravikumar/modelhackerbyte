class CreateStudentLabEntrollments < ActiveRecord::Migration[7.1]
  def change
    create_table :student_lab_entrollments do |t|
      t.belongs_to :user
      t.belongs_to :course
      t.belongs_to :course_lab
      t.string :status
      t.integer :percentage
      t.integer :score
      t.timestamps
    end
  end
end
