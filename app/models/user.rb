class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :image
  has_one_attached :cover_image

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :student_lab_codes
  has_many :assign_student_labs 
  has_many :course_entrolls
  has_many :student_lab_entrollments
  has_one :admin_consultant
  has_one :student_detail
  # has_one :consultant_admin, class_name: "User", foreign_key: "belongs_user_id"
  belongs_to :consultant_admins, class_name: "ConsultantAdmin", foreign_key: "belongs_user_id", optional: true 
  has_many :student_course_entrollment



  

  private

   def self.get_current_id(userId)
      user = find_by(id: userId)
      if user&.belongs_user_id == "superadmin"
        id = 1
      else
        id = user&.belongs_user_id
      end
      id 
   end


end
