class PetApplicationsController < ApplicationController
	def create
		# pet_app = PetApplication.find_by_pet_app_ids(params[:pet_id], params[:app_id])
		pet_app = PetApplication.create!(application_id: params[:app_id], pet_id: params[:pet_id])
		app_id = pet_app.application.id
		redirect_to "/applications/#{app_id.to_i}"
	end
end