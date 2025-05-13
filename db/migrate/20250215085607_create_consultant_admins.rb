class CreateConsultantAdmins < ActiveRecord::Migration[7.1]
  def change
    create_table :consultant_admins do |t|
      t.string :name
      t.string :location
      t.text  :address
      t.integer :branch_admin_id
      t.belongs_to :admin_consultant
      t.timestamps
    end
  end
end
