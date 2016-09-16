class CreateApplicationStatusNotes < ActiveRecord::Migration
  def change
    create_table :application_status_notes do |t|
      t.references :application_status, index: true, foreign_key: true
      t.text :content
      t.references :team_member, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
