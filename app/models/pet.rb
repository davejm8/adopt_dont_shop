class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  belongs_to :shelter
	has_many :pet_applications
	has_many :applications, through: :pet_applications

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

	def approved?(id)
		approved_pets = Pet.joins(:applications).where(pet_applications: {approval: 1, application_id: id})
		approved_pets.include?(self)
	end

	def rejected?(id)
		rejected_pets = Pet.joins(:applications).where(pet_applications: {approval: 2, application_id: id})
		rejected_pets.include?(self)
	end

	def self.average_age
		average(:age).to_i
	end

	def self.num_pets
		count
	end

	def self.shelter_pets_with_pending_apps(shelter_id)
		joins(:applications).where(shelter_id: shelter_id, applications: {status: 1})
	end
end
