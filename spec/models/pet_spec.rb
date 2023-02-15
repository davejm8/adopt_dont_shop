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
																status: 'Accepted')
		@app_2 = Application.create!(name: 'Maria', 
																street: '152 Steve St.', 
																city: 'Denver', 
																state: 'CO', 
																zip: '40208',
																desc: 'I have home',
																status: 'Pending')
		@app_3 = Application.create!(name: 'John', 
																street: '152 Steve St.', 
																city: 'Denver', 
																state: 'CO', 
																zip: '40208',
																desc: 'I have home',
																status: 'Pending')
		@app_4 = Application.create!(name: 'Chris', 
																street: '152 Steve St.', 
																city: 'Denver', 
																state: 'CO', 
																zip: '40208',
																desc: 'I have home',
																status: 'Pending')
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 5, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: false)
    @pet_4 = @shelter_1.pets.create(name: 'Ms. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_5 = @shelter_1.pets.create(name: 'Frank', breed: 'shorthair', age: 5, adoptable: true)
    @pet_6 = @shelter_1.pets.create(name: 'Sushi', breed: 'ragdoll', age: 5, adoptable: true)
		PetApplication.create!(application: @app_1, pet: @pet_1, approval: 0)
		PetApplication.create!(application: @app_1, pet: @pet_2, approval: 1)
		PetApplication.create!(application: @app_1, pet: @pet_3, approval: 2)
		PetApplication.create!(application: @app_2, pet: @pet_4, approval: 0)
		PetApplication.create!(application: @app_2, pet: @pet_5, approval: 0)
		PetApplication.create!(application: @app_2, pet: @pet_6, approval: 0)
		PetApplication.create!(application: @app_3, pet: @pet_2, approval: 0)
		PetApplication.create!(application: @app_4, pet: @pet_2, approval: 0)
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
        expect(Pet.search("Claw")).to eq([@pet_2])
      end
    end

    describe '#adoptable' do
      it 'returns adoptable pets' do
        expect(Pet.adoptable).to eq([@pet_1, @pet_2, @pet_4, @pet_5, @pet_6])
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

  describe '#average_age' do
    it 'shows average age of a collection of pets' do
      expect(@shelter_1.pets.average_age).to eq(5)
    end
  end

  describe '#pet_count' do
    it 'shows number of pets in a collection' do
      expect(@shelter_1.pets.num_pets). to eq(6)
    end
  end

	describe '#shelter_pets_pending_apps' do
		it 'returns pets who have pending applciations' do
			expect(Pet.shelter_pets_with_pending_apps(@shelter_1)).to eq([@pet_2, @pet_4, @pet_5, @pet_6])
		end
	end

	describe '.pending_application_ids' do
		it 'returns an array with application ids for pending applications' do
			expect(@pet_2.pending_applications).to eq([@app_3, @app_4])
		end
	end
end
