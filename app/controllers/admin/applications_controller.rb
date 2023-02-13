class Admin::ApplicationsController < ApplicationController
  def show
		@application = Application.find(params[:id])
		@pets = @application.pets
		@pet_applications = @application.pet_applications
    if PetApplication.all_approved?(@application.id)
      @application.update status: 2
    elsif PetApplication.all_rejected?(@application.id)
      @application.update status: 3
    end
  end

	# def update
	# 	@application = Application.find(params[:id])
	# 	@path = "/admin/applications/#{@application.id}?approved=#{params[:approved]}"
	# 	redirect_to @path
	# end
end