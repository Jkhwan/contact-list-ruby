class CreateContacts < ActiveRecord::Migration
  def up
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :importance
    end

    Contact.create(first_name: "Jason", last_name: "Wan", email: "jsw823@gmail.com", importance: 5)
    Contact.create(first_name: "Khurram", last_name: "Virani", email: "kv@gmail.com", importance: 3)
  end

  def down
    drop_table :contacts
  end
end
