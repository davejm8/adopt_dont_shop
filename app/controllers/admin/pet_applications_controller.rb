class Admin::PetApplicationsController < ApplicationController
	def update
		pet_application = PetApplication.where(pet_id: params[:pet_id], application_id: params[:application_id])
		pet_application.update(approval: params[:approval].to_i)
		redirect_to "/admin/applications/#{params[:application_id]}"
	end
end

# @pets.second.pet_applications.where(application_id: params[:id])