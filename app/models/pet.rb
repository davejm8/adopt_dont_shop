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

	def approved?
		approved_pets = Pet.joins(:applications).where(pet_applications: {approval: 1})
		approved_pets.include?(self)
	end

	def rejected?
		rejected_pets = Pet.joins(:applications).where(pet_applications: {approval: 2})
		rejected_pets.include?(self)
	end
end
