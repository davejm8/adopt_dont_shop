require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to(:shelter) }
    it { should have_many(:pet_applications) }
    it { should have_many(:applications).through(:pet_applications) }
		
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:age) }
    it { should validate_numericality_of(:age) }
  end

  before(:each) do
		@app_1 = Application.create!(name: 'Steve', 
																street: '152 Steve St.', 
																city: 'Denver', 
																state: 'CO', 
																zip: '40208',
																desc: 'I have home',
																status: 'Pending')
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
		PetApplication.create!(application: @app_1, pet: @pet_1, approval: 0)
		PetApplication.create!(application: @app_1, pet: @pet_2, approval: 1)
		PetApplication.create!(application: @app_1, pet: @pet_3, approval: 2)
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
        expect(Pet.search("Claw")).to eq([@pet_2])
      end
    end

    describe '#adoptable' do
      it 'returns adoptable pets' do
        expect(Pet.adoptable).to eq([@pet_1, @pet_2])
      end
    end

		describe 'approved?' do
			it 'returns pets who have been approved in applications' do
				expect(@pet_1.approved?(@app_1.id)).to eq(false)
				expect(@pet_2.approved?(@app_1.id)).to eq(true)
				expect(@pet_3.approved?(@app_1.id)).to eq(false)
			end
		end

		describe 'rejected?' do
			it 'returns pets who have been approved in applications' do
				expect(@pet_1.rejected?(@app_1.id)).to eq(false)
				expect(@pet_2.rejected?(@app_1.id)).to eq(false)
				expect(@pet_3.rejected?(@app_1.id)).to eq(true)
			end
		end
  end

  describe 'instance methods' do
    describe '.shelter_name' do
      it 'returns the shelter name for the given pet' do
        expect(@pet_3.shelter_name).to eq(@shelter_1.name)
      end
    end
  end
end
