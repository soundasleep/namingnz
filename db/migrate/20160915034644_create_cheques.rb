class CreateCheques < ActiveRecord::Migration
  def change
    create_table :cheques do |t|
      t.references :team_member, null: false, index: true, foreign_key: true
      t.references :application, null: false, index: true, foreign_key: true
      t.decimal :amount, null: false
      t.string :payee, null: false

      t.timestamps null: false
      t.datetime :spent_at
      t.datetime :cancelled_at
    end
  end
end
