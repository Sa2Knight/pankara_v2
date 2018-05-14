class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :providder
      t.string :uid
      t.string :display_name
      t.string :image_url

      t.timestamps
    end
  end
end
