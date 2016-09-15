class CreateApplicantStatuses < ActiveRecord::Migration
  def change
    create_table :applicant_statuses do |t|
      t.references :team_member, index: true, null: false, foreign_key: true
      t.references :applicant, index: true, null: false, foreign_key: true
      t.string :status, null: false

      t.timestamps null: false
    end
  end
end
