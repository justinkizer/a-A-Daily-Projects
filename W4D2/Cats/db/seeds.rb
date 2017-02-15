# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Cat.create!(birth_date: "2001/02/14", color: "blue", name: "fido", sex: "f", description: "great dog")
Cat.create!(birth_date: "1908/02/14", color: "orange", name: "erma", sex: "m", description: "great cat")
Cat.create!(birth_date: "1954/08/21", color: "yellow", name: "rupert", sex: "m", description: "this cat neat")
Cat.create!(birth_date: "2010/03/02", color: "white", name: "eugene", sex: "f", description: "this cat is cool")
