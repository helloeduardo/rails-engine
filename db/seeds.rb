# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

# before running "rake db:seed", do the following:
# - put the "rails-engine-development.pgdump" file in db/data/
# - put the "items.csv" file in db/data/

cmd = "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U $(whoami) -d rails_engine_development db/data/rails-engine-development.pgdump"
puts "Loading PostgreSQL Data dump into local database with command:"
puts cmd
system(cmd)

# TODO
# - Import the CSV data into the Items table
CSV.foreach(Rails.root.join('db/data/items.csv'), headers: true) do |row|

  Item.create!(
    id: row["id"].to_i,
    name: row["name"],
    description: row["description"],
    unit_price: (row["unit_price"].to_i * 0.01).round(2),
    merchant_id: row["merchant_id"].to_i,
    created_at: row["created_at"],
    updated_at: row["updated_at"]
  )

end

# - Add code to reset the primary key sequences on all 6 tables (merchants, items, customers, invoices, invoice_items, transactions)
ActiveRecord::Base.connection.tables.each do |table|
  ActiveRecord::Base.connection.reset_pk_sequence!(table)
end
