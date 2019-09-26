class ChangeContinuosCountToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :continuos_count, :int, :default => 1
  end
end
