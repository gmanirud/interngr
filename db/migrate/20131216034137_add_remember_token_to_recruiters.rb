class AddRememberTokenToRecruiters < ActiveRecord::Migration
  def change
  	add_column :recruiters, :remember_token, :string
    add_index  :recruiters, :remember_token
  end
end
