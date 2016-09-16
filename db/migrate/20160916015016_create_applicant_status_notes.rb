class CreateApplicantStatusNotes < ActiveRecord::Migration
  def change
    create_table :applicant_status_notes do |t|
      t.references :applicant_status, index: true, foreign_key: true
      t.text :content
      t.references :team_member, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
