# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Sport.delete_all
Sport.create!(name: "Surfing")
Sport.create!(name: "Windsurfing")
Sport.create!(name: "Kitesurfing")

Spot.delete_all
Spot.create!(name: 'Soma Bay', latitude: 26.844535, longitude: 33.956664, 
	:sports => Sport.where(:name => ['Kitesurfing', 'Windsurfing']))

Spot.create!(name: 'El Gouna', latitude: 27.396147, longitude: 33.687928,
	:sports => Sport.where(:name => ['Kitesurfing', 'Windsurfing']))

Spot.create!(name: 'Sharm el Sheikh, Nabq', latitude: 28.053572, longitude: 34.441985,
	:sports => Sport.where(:name => ['Kitesurfing', 'Windsurfing']))

Spot.create!(name: 'Marsa Alam - Blue Lagoon', latitude: 24.910606, longitude: 34.976907,
	:sports => Sport.where(:name => ['Kitesurfing', 'Windsurfing']))

Photo.delete_all
Photo.create!(:image => open(File.join(Rails.root, 'public/uploads/photo/Spot/1/1.jpg')), imageable_id: 1, imageable_type: 'Spot')
Photo.create!(:image => open(File.join(Rails.root, 'public/uploads/photo/Spot/1/soma-bay-holiday-10.jpg')), imageable_id: 1, imageable_type: 'Spot')
Photo.create!(:image => open(File.join(Rails.root, 'public/uploads/photo/Spot/2/10.jpg')), imageable_id: 2, imageable_type: 'Spot')
Photo.create!(:image => open(File.join(Rails.root, 'public/uploads/photo/Spot/2/1280_2.jpeg')), imageable_id: 2, imageable_type: 'Spot')
Photo.create!(:image => open(File.join(Rails.root, 'public/uploads/photo/Spot/2/1280x.jpeg')), imageable_id: 2, imageable_type: 'Spot')
Photo.create!(:image => open(File.join(Rails.root, 'public/uploads/photo/Spot/3/kite-junkies-amazing.jpg')), imageable_id: 3, imageable_type: 'Spot')
Photo.create!(:image => open(File.join(Rails.root, 'public/uploads/photo/Spot/3/panoramic-1a.jpg')), imageable_id: 3, imageable_type: 'Spot')

School.delete_all
School.create!(spot_id: 1, name: 'Tornado Surf', latitude: 26.795834, longitude: 33.941896,
	link: 'http://www.tornadosurf.com', affiliation: 1)



