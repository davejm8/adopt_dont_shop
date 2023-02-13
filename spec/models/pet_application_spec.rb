require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  it { should belong_to :pet}
  it { should belong_to :application}
	it { should define_enum_for(:approval).with_values(["Pending", "Approved", "Rejected"])}
end
