class WelcomeController < ApplicationController
  def index
    @requests = Request.all
  end
end
