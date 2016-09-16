class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :application, index: true, foreign_key: true
      t.references :team_member, index: true, foreign_key: true
      t.string :vote

      t.timestamps null: false
    end
  end
end
