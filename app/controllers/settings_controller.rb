class SettingsController < ApplicationController

  def edit
    @settings = Settings.new
  end

  def update
    @settings = Settings.new
    @settings.save(params[:settings])
    redirect_to settings_path, :notice => "Settings successfully updated."
  end

end
