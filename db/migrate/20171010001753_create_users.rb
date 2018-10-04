class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email, null: false, default: ""
      t.string :display_name, null: false
      t.string :site_name, null: false
      t.string :site_url, null: false
      t.text :site_description, null: false
      t.boolean :is_active, default: false
      t.boolean :is_admin, default: false
      t.datetime :last_reviewed
      t.datetime :user_last_updated, default: -> { 'CURRENT_TIMESTAMP' }
      t.timestamps
    end
  end
end
