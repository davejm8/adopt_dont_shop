class Admin::ApplicationsController < ApplicationController
  def show
		@application = Application.find(params[:id])
		@pets = @application.pets
		@pet_applications = @application.pet_applications
  end

	def update
		@application = Application.find(params[:id])
		@path = "/admin/applications/#{@application.id}?approved=#{params[:approved]}"
		redirect_to @path
	end
end