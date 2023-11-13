# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ADMIN_TEST_EMAIL = "admin@admin"
ADMIN_TEST_PASSWORD = "adminadmin"

Admin.create!(
  email: ADMIN_TEST_EMAIL,
  encrypted_password: ADMIN_TEST_PASSWORD,
  password: ADMIN_TEST_PASSWORD,
  password_confirmation: ADMIN_TEST_PASSWORD,
)
puts "[Seeds] Created Admin user"