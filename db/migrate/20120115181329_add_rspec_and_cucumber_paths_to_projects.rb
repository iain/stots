class AddRspecAndCucumberPathsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :rspec_url, :string

    add_column :projects, :cucumber_url, :string

  end
end
