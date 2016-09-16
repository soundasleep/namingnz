class AddFormDetailsToApplicant < ActiveRecord::Migration
  def change
    add_column :applicants, :form_details, :text
  end
end
