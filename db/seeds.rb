# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

user1 = User.create!(email:"thiru@yopmail.com",password:"thiru1234",role:"superadmin",username: "thiru")

user3 = User.create!(email:"thiru2@yopmail.com",password:"thiru1234",role:"admin",username: "thiru")



# INSERT INTO `admin_consultants` (`branch_Name`, `owner_Name`, `phone_Number`, `email`, `gender`, `location`, `address`, `user_id`, `created_at`, `updated_at`) VALUES ('PUMO', 'II', '09629425158', 'kumaranthiru80@gmail.com', , 'Nilgiris', 'south coimbator\nsouth coimbatore', 5, '2025-03-29 13:16:00.468829', '2025-03-29 13:16:00.468829')


admin = AdminConsultant.create(branch_Name: "HackerByte",owner_Name: 'thiru',phone_Number: 9629425158,email: user3.email,gender:'Male',user_id: user3.id)

consultant = ConsultantAdmin.create(name: "HackerByte",branch_admin_id: user3.id,admin_consultant_id: admin.id)

user2 = User.create!(email:"thiru1@yopmail.com",password:"thiru1234",role:"student",username: "thiru",belongs_user_id: admin.id)

user4 = User.create!(email:"thiru3@yopmail.com",password:"thiru1234",role:"educator",username: "thiru",belongs_user_id: admin.id)

user = Sector.create!(name:"IT",show_login: true)


# INSERT INTO `consultant_admins` (`name`, `location`, `address`, `branch_admin_id`, `admin_consultant_id`, ) VALUES ('PUMO', 'Ariyalur', 'dd', 5, 1, )

student_details = StudentDetail.create(first_name: "demo",last_name: "account",gender: "Male",user_id: user2.id,)

# INSERT INTO `student_details` (`first_name`, `last_name`, `gender`, `dob`, `phone_number`, `location`, `course_details`, `user_id`, `created_at`, `updated_at`) VALUES ('dwsfds', 'ds', 'Male', NULL, '', 'Ramanathapuram', NULL, 5, '2025-03-29 14:18:49.776886', '2025-03-29 14:18:49.776886')