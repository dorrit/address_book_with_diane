class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.column :last_name, :string
      t.column :first_name, :string

      t.timestamps
    end
  end
end