class SettingsController < ApplicationController

  respond_to :xml, :json, :only => [ :index ]

  def index
    @settings = Setting.group(params[:group]).to_hash
    respond_with @settings, :root => "settings", :dasherize => false
  end

  def edit
    @settings = Settings.new
  end

  def update
    @settings = Settings.new
    @settings.save(params[:settings])
    redirect_to settings_path, :notice => "Settings successfully updated."
  end

end
