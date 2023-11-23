# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者のSeed作成
require_relative "seeds/admin"

DEV_ADMIN_EMAIL = "admin@admin"
DEV_ADMIN_PASSWORD = "adminadmin"

Seeds::Admins.create(
  DEV_ADMIN_EMAIL,
  DEV_ADMIN_PASSWORD,
)

# 顧客のSeed作成
require_relative "seeds/customers"

DEV_CUSTOMER_EMAIL = "dev@example.com"
DEV_CUSTOMER_PASSWORD = "password"

FAKE_CUSTOMERS_COUNT = 20

Seeds::Customers.create_dev_customer(
  DEV_CUSTOMER_EMAIL,
  DEV_CUSTOMER_PASSWORD
)
Seeds::Customers.create_fake_customers(FAKE_CUSTOMERS_COUNT)

# ジャンルのSeed作成
require_relative "seeds/genres"
Seeds::Genres.create

# 商品のSeed作成
require_relative "seeds/items"
Seeds::Items.create

require_relative "seeds/orders"
Seeds::Orders.create
