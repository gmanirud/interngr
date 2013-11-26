class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :fname
      t.string :lname
      t.string :email
      t.integer :year
      t.string :school
      t.string :discipline

      t.timestamps
    end
  end
end
