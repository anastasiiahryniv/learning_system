# frozen_string_literal: true

class AddDeviseToInstructors < ActiveRecord::Migration[6.1]
  def change
    change_table :instructors do |t|
      t.string :encrypted_password, null: false, default: ""

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      # Uncomment below if timestamps were not included in your original model.
      # t.timestamps null: false
    end

    # add_index :instructors, :confirmation_token,   unique: true
    # add_index :instructors, :unlock_token,         unique: true
  end

  def self.down
  end
end
