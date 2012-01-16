class Airbrake::ErrorsController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:create]

  def create
    Airbrake::Error.import(params[:errors])
    head :ok
  end

end
