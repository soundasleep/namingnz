class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.references :applicant, null: false, index: true, foreign_key: true
      t.string :category, null: false
      t.integer :latest_status_id, null: true, index: true

      t.timestamps null: false
    end
  end
end
