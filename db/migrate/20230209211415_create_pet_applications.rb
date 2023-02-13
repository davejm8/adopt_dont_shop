class CreatePetApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_applications do |t|
      t.references :application, foreign_key: true
      t.references :pet, foreign_key: true
			t.integer :approval, default: 0

      t.timestamps
    end
  end
end
