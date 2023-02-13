class ApplicationsController < ApplicationController
	def show
		@application = Application.find(params[:id])
		@pets = @application.pets
		if params[:pet_name].present?
			@pet_search = Pet.search(params[:pet_name])
		else
			@pet_search = []
		end
  end

	def new

	end

	def create
		application = Application.new(app_params)
    if application.save
		  redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Required Information Missing"
    end
	end

	def update
		application = Application.find(params[:id])
		if desc_params.present?
			application.update!(desc_params)
			application.update! status: 1
		end
		redirect_to "/applications/#{application.id}"
	end

	private
	
	def app_params
		params.permit(:name, :street, :city, :state, :zip, :status)
	end

	def desc_params
		params.permit(:desc)
	end
end