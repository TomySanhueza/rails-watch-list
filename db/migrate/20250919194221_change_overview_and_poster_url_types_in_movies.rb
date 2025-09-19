class ChangeOverviewAndPosterUrlTypesInMovies < ActiveRecord::Migration[7.1]
  def change
    change_column :movies, :overview, :text
    change_column :movies, :poster_url, :string
  end
end
