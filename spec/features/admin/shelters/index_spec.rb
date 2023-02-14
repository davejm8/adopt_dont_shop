require 'rails_helper'

  RSpec.describe 'admin shelter index' do

    let!(:shelter_1)  { Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) }
    let!(:shelter_2)  { Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5) }
    let!(:shelter_3)  { Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10) }
    let!(:shelter_4)  { Shelter.create!(name: 'All Paws Shelter', city: 'Los Angeles, CA', foster_program: true, rank: 4) }
		let!(:pet_1) { shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true) }
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
		let!(:petapp_1) { PetApplication.create!(pet: pet_1, application: app_1)}
		let!(:petapp_2) { PetApplication.create!(pet: pet_2, application: app_2)}
  
    it 'displays all shelter names in reverse alphabetical order' do
      visit '/admin/shelters'

      expect(shelter_2.name).to appear_before(shelter_3.name)
      expect(shelter_3.name).to appear_before(shelter_1.name)
    end

		it 'has a section with pending applications' do
			visit '/admin/shelters'

			expect(page).to have_link('Shelters with Pending Applications')
		end

		it 'filters shelters to show only those with pending applications' do
			visit '/admin/shelters'

			expect(page).to have_content(shelter_1.name)
			expect(page).to have_content(shelter_2.name)
			expect(page).to have_content(shelter_3.name)

			click_link 'Shelters with Pending Applications'

			expect(current_path).to eq('/admin/shelters')
			expect(page).to have_content(shelter_1.name)
			expect(page).to_not have_content(shelter_2.name)
			expect(page).to_not have_content(shelter_3.name)
		end

		it 'lists the shelters with pending applications in alphabetical order' do
			pet_3 = shelter_4.pets.create!(name: 'Koa', breed: 'mixed breed', age: 9, adoptable: true)
			pet_4 = shelter_4.pets.create!(name: 'Cookie', breed: 'Yorkie', age: 3, adoptable: true)
			app_3 = Application.create!(name: 'Steve', 
																  street: '152 Steve St.', 
																  city: 'Denver', 
																  state: 'CO', 
																  zip: '40208',
																  desc: 'I have home',
																  status: 'Pending')
				petapp_1 = PetApplication.create!(pet: pet_4, application: app_3)

			
			visit '/admin/shelters'

			click_link 'Shelters with Pending Applications'

			expect(shelter_4.name).to appear_before(shelter_1.name)
			expect(page).to have_content(shelter_1.name)
		end
  end