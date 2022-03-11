class CreateUnvotes < ActiveRecord::Migration[6.1]
  def change
    create_table :unvotes do |t|
      t.belongs_to :unvotable, polymorphic: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
