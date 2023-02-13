class PetApplication < ApplicationRecord
  belongs_to :application
  belongs_to :pet
	enum approval: [ "Pending", "Approved", "Rejected" ]
end
