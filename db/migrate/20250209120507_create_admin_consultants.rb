class CreateAdminConsultants < ActiveRecord::Migration[7.1]
  def change
    create_table :admin_consultants do |t|
      t.string :branch_Name
      t.string :owner_Name
      t.string :phone_Number
      t.string :email
      t.string :gender
      t.string :location
      t.text :address
      t.belongs_to :user
      t.timestamps
    end
  end
end
