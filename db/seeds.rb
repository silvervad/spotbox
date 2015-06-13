# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Sport.create!(name: "Surfing")
Sport.create!(name: "Windsurfing")
Sport.create!(name: "Kitesurfing")

Continent.create!([
  {name: "Africa"},
	{name: "Europe"},
	{name: "Asia"},
	{name: "North America"},
	{name: "South America"},
	{name: "Australia"},
])

Country.create!(name: "Egypt", continent: Continent.find_by(name: 'Africa'))
Country.create!(name: "Tanzania", continent: Continent.find_by(name: 'Africa'))
Country.create!(name: "Kenya", continent: Continent.find_by(name: 'Africa'))
Country.create!(name: "Mauritius", continent: Continent.find_by(name: 'Africa'))
Country.create!(name: "Dominican Republic", continent: Continent.find_by(name: 'North America'))

School.create!(spot_id: 1, name: 'Tornado Surf', latitude: 26.795834, longitude: 33.941896,
	link: 'http://www.tornadosurf.com', affiliation: 1)

