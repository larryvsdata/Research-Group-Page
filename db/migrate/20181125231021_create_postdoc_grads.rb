class CreatePostdocGrads < ActiveRecord::Migration
  def change
    create_table :postdoc_grads do |t|
      t.integer :postdoc_id
      t.integer :grad_id
    end
  end
end
