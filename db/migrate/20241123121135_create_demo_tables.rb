class CreateDemoTables < ActiveRecord::Migration[7.1]
  def change
    create_table :demo_tables do |t|
      t.string :name
      t.integer :age
      t.string :city

      t.timestamps
    end
  end
end
