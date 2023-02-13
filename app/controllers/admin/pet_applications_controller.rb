class Admin::PetApplicationsController < ApplicationController
	def update
		pet_application = PetApplication.find_by_pet_app_ids(params[:pet_id], params[:application_id])
		pet_application.update(approval: params[:approval].to_i)
		redirect_to "/admin/applications/#{params[:application_id]}"
	end
end