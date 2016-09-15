class CreateApplicants < ActiveRecord::Migration
  def change
    create_table :applicants do |t|
      t.references :team_member, index: true, foreign_key: true
      t.integer :latest_status_id, null: true, index: true
      t.string :nickname

      t.timestamps null: false
    end
  end
end
