class CreateBadgesQuestionJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_table :badge_questions do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :question, foreign_key: true
    end
  end
end
