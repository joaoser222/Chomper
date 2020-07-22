class CreateAdverts < ActiveRecord::Migration[6.0]
  def change
    create_table :adverts do |t|
      t.string :description,  null: false, default: ''
      t.string :status,       null: false, default: 'a'
      t.decimal :price,       null: false, precision: 10, scale: 3
      t.string :image,        null: false, default: ''

      t.timestamps
    end

    add_reference :adverts, :user, index: true
  end
end
