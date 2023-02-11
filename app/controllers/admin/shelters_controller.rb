class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.order_by_alpha_desc
  end
end