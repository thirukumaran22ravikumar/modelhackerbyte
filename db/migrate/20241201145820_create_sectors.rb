class CreateSectors < ActiveRecord::Migration[7.1]
  def change
    create_table :sectors do |t|
      t.string :name 
      t.boolean :show_login
      t.timestamps
    end
  end
end
