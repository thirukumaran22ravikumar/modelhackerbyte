class CreateAssignStudentLabs < ActiveRecord::Migration[7.1]
  def change
    create_table :assign_student_labs do |t|
      t.belongs_to :user
      t.belongs_to :course
      t.belongs_to  :course_lab
      t.belongs_to  :course_sub_lab
      t.datetime  :start_time
      t.datetime  :end_time
      t.integer :version
      t.string  :status
      t.integer :score
      t.timestamps
    end
  end
end
