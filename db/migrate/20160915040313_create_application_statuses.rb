class CreateApplicationStatuses < ActiveRecord::Migration
  def change
    create_table :application_statuses do |t|
      t.references :application, null: false, index: true, foreign_key: true
      t.references :team_member, null: false, index: true, foreign_key: true
      t.string :status, null: false
      t.string :contact_method
      t.string :contact_detail
      t.text :content

      t.timestamps null: false
    end
  end
end
