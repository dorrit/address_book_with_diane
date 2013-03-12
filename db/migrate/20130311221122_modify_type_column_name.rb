class ModifyTypeColumnName < ActiveRecord::Migration
  
  def change
    change_table :emails do |t|
    t.rename :type, :email_type
    end

    change_table :phones do |t|
    t.rename :type, :phone_type
    end
  end
end
