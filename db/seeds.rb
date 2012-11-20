# Cotopaxi | Scrum Management Tool
# Copyright (C) 2012  Patricio Cano
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.create [nickname: 'AdM', email: 'admin@localhost.com', password: 'adminPassword', password_confirmation: 'adminPassword', stakeholder: true]
scrum = User.create [nickname: 'ScM', email: 'scrum@localhost.com', password: 'scrumPassword', password_confirmation: 'scrumPassword']
product = User.create [nickname: 'PrO', email: 'po@localhost.com', password: 'poPassword', password_confirmation: 'poPassword']
cust = User.create [nickname: 'CuS', email: 'cust@localhost.com', password: 'custPassword', password_confirmation: 'custPassword']
team = User.create [nickname: 'TeM', email: 'team@localhost.com', password: 'teamPassword', password_confirmation: 'teamPassword']