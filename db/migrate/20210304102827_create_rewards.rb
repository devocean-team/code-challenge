class CreateRewards < ActiveRecord::Migration[6.0]
  def change
    create_table :rewards do |t|
      t.string :name
      t.integer :points

      t.timestamps
    end
  end
end
