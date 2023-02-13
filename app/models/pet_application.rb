class PetApplication < ApplicationRecord
  belongs_to :application
  belongs_to :pet
	enum approval: [ "Pending", "Approved", "Rejected" ]

	def self.find_by_pet_app_ids(pet_id, app_id)
		where(pet_id: pet_id, application_id: app_id).first
	end

	def self.all_approved?(id)
		where(application_id: id).count == where(application_id: id, approval: 1).count
	end

	def self.all_rejected?(id)
		where(application_id: id).count == where(application_id: id, approval: 2).count
	end
end
