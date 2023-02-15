class Admin::SheltersController < ApplicationController
  def index
		@shelters = Shelter.order_by_alpha_desc
		if params[:filter_pending]
			@shelters = Shelter.pending_applications
		end
  end

	def show
		@shelter = Shelter.find(params[:id])
		@pets_pending_apps = Pet.shelter_pets_with_pending_apps(@shelter.id)
	end
end