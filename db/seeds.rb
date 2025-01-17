# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Shelter.destroy_all
# Pet.destroy_all
# Application.destroy_all
# PetApplication.destroy_all

shelter_1 = Shelter.create!(name: 'Aurora shelter', street: "Steve St.", city: 'Aurora, CO', zip: 02345, foster_program: false, rank: 9)
shelter_2 = Shelter.create!(name: 'Steve shelter', street: "Not Steve St.", city: 'Denver, CO', zip: 02333, foster_program: false, rank: 9)
shelter_3 = Shelter.create!(name: 'Bill shelter', street: "Bill St.", city: 'Billville, CO', zip: 02322, foster_program: false, rank: 9)

pet_1 = shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
pet_2 = shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
pet_3 = shelter_3.pets.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
pet_4 = shelter_1.pets.create!(name: 'Ms. Pirate', breed: 'tuxedo shorthair', age: 8, adoptable: true)

app_1 = Application.create!(name: 'Steve', street: '152 Steve St.', city: 'Denver', state: 'CO', zip: '40208', status: 'In Progress')
app_2 = Application.create!(name: 'Beve', street: '100 Beve Pwky.', city: 'Denver', state: 'CO', zip: '40218', status: 'In Progress')
PetApplication.create!(pet: pet_1, application: app_1 )
PetApplication.create!(pet: pet_2, application: app_2 )