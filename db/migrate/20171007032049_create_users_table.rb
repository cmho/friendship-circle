class CreateUsersTable < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :display_name, null: false
      t.string :site_name, null: false
      t.string :site_url, null: false
      t.text :site_description
      t.boolean :is_admin, default: false
      t.boolean :is_approved, default: false
    end
  end
end
