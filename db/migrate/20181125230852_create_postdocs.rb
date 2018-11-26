class CreatePostdocs < ActiveRecord::Migration
  def change
    create_table :postdocs do |t|
      t.string :name
      t.string :topic
      t.integer :professor_id
    end
  end
end
