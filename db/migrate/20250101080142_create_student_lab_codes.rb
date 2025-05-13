class CreateStudentLabCodes < ActiveRecord::Migration[7.1]
  def change
    create_table :student_lab_codes do |t|

      t.belongs_to :user
      t.belongs_to :course
      t.belongs_to :course_lab
      t.belongs_to  :course_sub_lab
      t.belongs_to  :assign_student_lab
      t.string :lab_type
      t.integer  :language_id 
      t.text  :code_data
      t.text  :output_data
      t.string  :version
      t.string  :take_time
      t.timestamps
    end
  end
end
