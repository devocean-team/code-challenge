class AddBankToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :bank, foreign_key: true
  end
end
