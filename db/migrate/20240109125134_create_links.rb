class CreateLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :links do |t|
      t.text :original_url
      t.string :short_url
      t.integer :visit_count, default: 0
      t.string :password

      t.timestamps
    end
  end
end
