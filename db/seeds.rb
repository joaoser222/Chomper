# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(
  name: 'admin',
  email: 'admin@chomper.com',
  password: '123456789',
  kind: 'admin',
  latitude: -15.7744227,
  longitude: -48.0772946
)
