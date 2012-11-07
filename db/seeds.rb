# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#admin = User.create [nickname: 'AdM', email: 'admin@localhost.com', password: 'adminPassword', password_confirmation: 'adminPassword', stakeholder: true]
scrum = User.create [nickname: 'ScM', email: 'scrum@localhost.com', password: 'scrumPassword', password_confirmation: 'scrumPassword']
product = User.create [nickname: 'PrO', email: 'po@localhost.com', password: 'poPassword', password_confirmation: 'poPassword']
cust = User.create [nickname: 'CuS', email: 'cust@localhost.com', password: 'custPassword', password_confirmation: 'custPassword']
team = User.create [nickname: 'TeM', email: 'team@localhost.com', password: 'teamPassword', password_confirmation: 'teamPassword']