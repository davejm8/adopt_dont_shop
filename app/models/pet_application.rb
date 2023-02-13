class PetApplication < ApplicationRecord
  belongs_to :application
  belongs_to :pet
	enum approval: [ "Pending", "Approved", "Rejected" ]

	def self.find_by_pet_app_ids(pet_id, app_id)
		where(pet_id: pet_id, application_id: app_id).first
	end
end
