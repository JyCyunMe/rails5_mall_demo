class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.integer :user_id
      t.string :role_name
      t.string :grant_urls

      t.timestamps
    end
  end
end
