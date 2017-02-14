# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.new(username: 'jarjar').save
User.new(username: 'maul').save
User.new(username: 'kylo').save
User.new(username: 'wicket').save

Contact.new(name: 'Jarjar Binks', email: 'jj@jj.com', user_id: 1).save
Contact.new(name: 'Darth Maul', email: 'mrmaul@mm.com', user_id: 2).save
Contact.new(name: 'Kylo Ren', email: 'kylo@klr.com', user_id: 3).save
# Contact.new(name: 'Wicket the Ewok', email: 'fuzzyman@ewoks.me', user_id: 4).save
Contact.new(name: 'Emporer Palpatine', email: 'palpy@tine.net', user_id: 4).save

ContactShare.new(contact_id: 4, user_id: 3).save
