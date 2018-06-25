class AddMemberToContacts < ActiveRecord::Migration[5.1]
  def change
    add_reference :contacts, :member, foreign_key: true
  end
end
