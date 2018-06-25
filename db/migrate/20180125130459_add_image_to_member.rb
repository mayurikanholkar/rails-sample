class AddImageToMember < ActiveRecord::Migration[5.1]
  def up
    add_attachment :members, :image
  end
 
  def down
    remove_attachment :members, :image
  end
end
