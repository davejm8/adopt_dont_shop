class Admin::SheltersController < ApplicationController
  def index
		@shelters = Shelter.order_by_alpha_desc
		if params[:filter_pending]
			@shelters = Shelter.pending_applications
		end
  end

	def show
		@shelter = Shelter.find(params[:id])
	end
end