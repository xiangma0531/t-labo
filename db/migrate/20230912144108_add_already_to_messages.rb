class AddAlreadyToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :already, :boolean
    Message.update_all(already: true)
    change_column_null :messages, :already, false
  end
end
