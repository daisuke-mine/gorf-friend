class Admins::ClientsController < ApplicationController
  
  def index
    @clients = Client.page(params[:page])
  end
end
