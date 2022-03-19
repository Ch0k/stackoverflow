class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.references :user, null: false
      t.references :commentable, polymorphic: true, null: false, index: true

      t.timestamps
    end
  end
end
