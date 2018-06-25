class CreateContacts < ActiveRecord::Migration[5.1]
  def up
  create_table :contacts do |t|

  t.string :mobile , :null => false, default: ""
  t.string :address , :null => false, default: ""

  end

  end

  def down
  drop_table :contacts

  end
end

