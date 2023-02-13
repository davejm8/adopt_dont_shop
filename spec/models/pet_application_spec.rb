require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  it { should belong_to :pet}
  it { should belong_to :application}
	it { should define_enum_for(:approval).with_values(["Pending", "Approved", "Rejected"])}

	describe 'class methods' do
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
		let!(:petapp_2) { PetApplication.create!(pet: pet_1, application: app_2)}
		let!(:petapp_3) { PetApplication.create!(pet: pet_2, application: app_1)}
		let!(:petapp_4) { PetApplication.create!(pet: pet_2, application: app_2)}

		it 'finds pet_applications by having both pet_id and app_id' do
			expect(PetApplication.find_by_pet_app_ids(pet_1.id, app_1.id)).to eq(petapp_1)
		end
	end
end
