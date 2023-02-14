class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  validates :name, :street, :city, :state, :zip, presence: true
	enum status: [ "In Progress", "Pending", "Accepted", "Rejected" ]

  def pet_names
    self.pets.pluck(:name)
  end

  # def app_approved(pet_id)
  #   app = Application.joins(:pets).where(pets: {id: pet_id}).pluck(:status)
  #   app.include?('Approved')
  # end
end
