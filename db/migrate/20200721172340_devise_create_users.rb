# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[6.0]

  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''
      t.string :jti,                null: false, default: ''
      ## Recoverable
      t.string                      :reset_password_token
      t.datetime                    :reset_password_sent_at

      ## Rememberable
      t.datetime                    :remember_created_at

      ## Personal data
      t.string :name,               null: false, default: ''
      t.string :avatar,             null: true
      t.string :phone,              null: true
      t.string :document,           null: true
      t.string :state,              null: true
      t.string :city,               null: true
      t.string :district,           null: true
      t.string :street,             null: true
      t.decimal :latitude,          null: false, precision: 10, scale: 8
      t.decimal :longitude,         null: false, precision: 11, scale: 8
      t.decimal :radius,            null: false, default: 0
      t.string :kind,               null: false, default: ''
      t.timestamps                  null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :jti, unique: true
  end
end
