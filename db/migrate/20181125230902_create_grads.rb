class CreateGrads < ActiveRecord::Migration
  def change
    create_table :grads do |t|
      t.string :name
      t.string :topic
    end
  end
end
