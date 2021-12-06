class FixUnique < ActiveRecord::Migration[6.1]
  def change
    remove_index :professionals, :name
  end
end
