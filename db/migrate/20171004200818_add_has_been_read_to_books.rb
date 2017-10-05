class AddHasBeenReadToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :has_been_read, :integer
  end
end
