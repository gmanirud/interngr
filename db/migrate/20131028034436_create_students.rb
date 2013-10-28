class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :email
      t.string :school
      t.string :city
      t.string :country
      t.string :year

      t.timestamps
    end
  end
end
