class AddRatingToBook < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :rating, :float
  end
end
