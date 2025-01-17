require 'rails_helper'

RSpec.describe 'admin applications show', type: :feature do
	let!(:shelter_1)  { Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) }
	let!(:shelter_2)  { Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5) }
	let!(:shelter_3)  { Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10) }
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
	let!(:petapp_4) { PetApplication.create!(pet: pet_1, application: app_2)}
	let!(:petapp_2) { PetApplication.create!(pet: pet_2, application: app_1)}
	let!(:petapp_3) { PetApplication.create!(pet: pet_2, application: app_2)}
  
	describe 'pet approval' do
		it 'shows a button to approve a pet for an application' do
			visit "/admin/applications/#{app_1.id}"

			expect(page).to have_content(app_1.pets.first.name)
			expect(page).to have_button("Approve #{app_1.pets.first.name}")
		end

		it 'when approving a pet, it refreshes page and the button is gone and it shows approved' do
			visit "/admin/applications/#{app_1.id}"

			click_button "Approve #{app_1.pets.first.name}"

			expect(current_path).to eq("/admin/applications/#{app_1.id}")
			expect(page).to_not have_button("Approve #{app_1.pets.first.name}")
			expect(page).to have_content('Approved')
		end

		describe 'pet rejection' do
			it 'shows a button to reject a pet for an application' do
				visit "/admin/applications/#{app_1.id}"

				expect(page).to have_content(app_1.pets.first.name)
				expect(page).to have_button("Reject #{app_1.pets.first.name}")
			end

			it 'when rejecting a pet, it refreshes the page and the button is gone and it shows rejected' do
				visit "/admin/applications/#{app_1.id}"

				click_button "Reject #{app_1.pets.first.name}"
	
				expect(current_path).to eq("/admin/applications/#{app_1.id}")
				expect(page).to_not have_button("Reject #{app_1.pets.first.name}")
				expect(page).to have_content('Rejected')
			end
		end

		describe 'changing approval of pets per application' do
			it 'when approving a pet, it doesnt affect other applications' do
				visit "/admin/applications/#{app_1.id}"

				expect(app_1.pets.first.approved?(app_1.id)).to eq(false)
				
				click_button "Approve #{app_1.pets.first.name}"

				expect(app_1.pets.first.approved?(app_1.id)).to eq(true)
				expect(app_2.pets.first.approved?(app_2.id)).to eq(false)
			end

			it 'when rejecting a pet, it doesnt affect other applications' do
				visit "/admin/applications/#{app_1.id}"

				expect(app_1.pets.first.rejected?(app_1.id)).to eq(false)

				click_button "Reject #{app_1.pets.first.name}"

				expect(app_1.pets.first.rejected?(app_1.id)).to eq(true)
				expect(app_2.pets.first.rejected?(app_2.id)).to eq(false)
			end
		end

		describe 'all pets approved shows application status approved' do
			it "I approve all pets for an application I see the applications status has changed to Approved" do
				visit "/admin/applications/#{app_1.id}"

				click_button "Approve #{app_1.pets.first.name}"
				click_button "Approve #{app_1.pets.last.name}"

				expect(page).to have_content("Status:\nAccepted")
			end

			it "approved status in one application does not affect another" do
				visit "/admin/applications/#{app_1.id}"

				click_button "Approve #{app_1.pets.first.name}"
				click_button "Approve #{app_1.pets.last.name}"

				expect(page).to have_content("Status:\nAccepted")

				visit "/admin/applications/#{app_2.id}"

				expect(page).to have_content("Status:\nIn Progress")
			end
		end

		describe 'pets who are approved or in a pending application can not be approved again' do
			it 'removes the approve button from show page when pet is adopted or pending adoption' do
				visit "/admin/applications/#{app_1.id}"

				click_button "Approve #{app_1.pets.first.name}"
				click_button "Approve #{app_1.pets.last.name}"
				
				visit "/admin/applications/#{app_2.id}"
				
				expect(page).to_not have_button("Accept #{app_2.pets.first.name}")
				expect(page).to_not have_button("Accept #{app_2.pets.last.name}")
				expect(page).to_not have_button("Reject #{app_2.pets.first.name}")
				expect(page).to_not have_button("Reject #{app_2.pets.last.name}")
				expect(page).to have_content("#{app_2.pets.first.name} has been adopted.")
				expect(page).to have_content("#{app_2.pets.last.name} has been adopted.")
			end
		end
	end
end