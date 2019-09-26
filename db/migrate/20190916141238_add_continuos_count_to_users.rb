class AddContinuosCountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :continuos_count, :int
  end
end
