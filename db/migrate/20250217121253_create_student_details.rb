class CreateStudentDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :student_details do |t|
      t.string  :first_name
      t.string :last_name
      t.string :gender
      t.datetime :dob
      t.string :phone_number
      t.string :location
      t.json :course_details
      t.belongs_to :user
      t.timestamps
    end
  end
end
