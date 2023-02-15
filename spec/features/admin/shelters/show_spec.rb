require 'rails_helper'

  RSpec.describe 'admin shelter show' do

    let!(:shelter_1)  { Shelter.create!(name: 'Aurora shelter', street: "Steve St.", city: 'Aurora, CO', zip: 02345, foster_program: false, rank: 9) }
    let!(:shelter_2)  { Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5) }
    let!(:shelter_3)  { Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10) }
		let!(:pet_1) { shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true) }
		let!(:pet_4) { shelter_1.pets.create!(name: 'Cookie', breed: 'tuxedo shorthair', age: 5, adoptable: true) }
		let!(:pet_5) { shelter_1.pets.create!(name: 'Frank', breed: 'tuxedo shorthair', age: 5, adoptable: true) }
		let!(:pet_3) { shelter_1.pets.create!(name: 'Larry', breed: 'tuxedo shorthair', age: 5, adoptable: true) }
		let!(:pet_2) { shelter_2.pets.create!(name: 'Ms. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true) }
		let!(:app_1) { Application.create!(name: 'Steve', 
			street: '152 Steve St.', 
			city: 'Denver', 
			state: 'CO', 
			zip: '40208',
			desc: 'I have home',
			status: 'Pending') }
		let!(:app_2) { Application.create!(name: 'Steve', 
			street: '152 Steve St.', 
			city: 'Denver', 
			state: 'CO', 
			zip: '40208',
			status: 'In Progress') }
		let!(:app_3) { Application.create!(name: 'Steve', 
			street: '152 Steve St.', 
			city: 'Denver', 
			state: 'CO', 
			zip: '40208',
			desc: 'I have home',
			status: 'Accepted') }
		let!(:app_4) { Application.create!(name: 'Steve', 
			street: '152 Steve St.', 
			city: 'Denver', 
			state: 'CO', 
			zip: '40208',
			status: 'Accepted') }
		let!(:app_5) { Application.create!(name: 'Steve', 
			street: '152 Steve St.', 
			city: 'Denver', 
			state: 'CO', 
			zip: '40208',
			status: 'Pending') }
		let!(:petapp_1) { PetApplication.create!(pet: pet_1, application: app_1)}
		let!(:petapp_2) { PetApplication.create!(pet: pet_2, application: app_2)}
		let!(:petapp_3) { PetApplication.create!(pet: pet_1, application: app_3)}
		let!(:petapp_4) { PetApplication.create!(pet: pet_3, application: app_4)}
		let!(:petapp_5) { PetApplication.create!(pet: pet_4, application: app_5)}
		let!(:petapp_6) { PetApplication.create!(pet: pet_5, application: app_5)}

    it 'shows a shelters name and full address' do
      visit "admin/shelters/#{shelter_1.id}"

      expect(page).to have_content("#{shelter_1.name}, #{shelter_1.street}, #{shelter_1.city}. #{shelter_1.zip}")
    end
    
		it 'has a section for statistics' do
			visit "admin/shelters/#{shelter_1.id}"

			expect(page).to have_content("Average pet age: #{shelter_1.adoptable_pets.average_age}")
			expect(page).to have_content("Number of adoptable pets: #{shelter_1.adoptable_pets.num_pets}")
		end

		it 'shows a count of adopted pets' do
			visit "admin/shelters/#{shelter_1.id}"

			expect(page).to have_content("Number of adopted pets: 2")
		end

		describe 'section: action required' do
			it 'has a list of all pets for this shelter that have a pending application' do
				visit "admin/shelters/#{shelter_1.id}"

				expect(page).to have_content("Action Required")
				expect(page).to have_content(pet_4.name)
				expect(page).to have_content(pet_5.name)
			end
		end
  end