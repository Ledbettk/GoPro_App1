class WelcomeController < ApplicationController
  layout "landing"

  def index
    render "landing"
   
  end
end
