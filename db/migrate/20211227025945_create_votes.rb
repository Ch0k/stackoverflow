class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.belongs_to :votable, polymorphic: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
