class AddSurnameToProfessionals < ActiveRecord::Migration[6.1]
  def change
    add_column :professionals, :surname, :string
  end
end
