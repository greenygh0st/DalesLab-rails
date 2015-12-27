# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

mateo = User.create(first_name: 'Dale', last_name: 'Myszewski', email: 'dale@daleslab.com', password: 'Mateo1', password_confirmation: 'Mateo1', role: 'admin')
