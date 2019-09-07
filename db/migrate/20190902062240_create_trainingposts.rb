class CreateTrainingposts < ActiveRecord::Migration[5.2]
  def change
    create_table :trainingposts do |t|
      t.string :title
      t.string :content
      t.string :training_part
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
