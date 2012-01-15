class AddCoverageUrlToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :coverage_url, :string

  end
end
