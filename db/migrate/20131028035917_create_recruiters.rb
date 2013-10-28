class CreateRecruiters < ActiveRecord::Migration
  def change
    create_table :recruiters do |t|
      t.string :name
      t.string :email
      t.string :company
      t.string :city
      t.string :country

      t.timestamps
    end
  end
end
