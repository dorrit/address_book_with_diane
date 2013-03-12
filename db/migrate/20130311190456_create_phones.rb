class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.column :phone_number, :string
      t.column :type, :string
      t.column :contact_id, :integer

      t.timestamps
    end
  end
end
