class CreateTeamMembers < ActiveRecord::Migration
  def change
    create_table :team_members do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone, null: false

      t.timestamps null: false
    end
  end
end
