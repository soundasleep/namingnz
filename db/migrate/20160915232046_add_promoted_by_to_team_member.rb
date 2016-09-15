class AddPromotedByToTeamMember < ActiveRecord::Migration
  def change
    change_table :team_members do |t|
      t.integer :promoted_by_id, null: true, index: true, foreign_key: true
    end
  end
end
