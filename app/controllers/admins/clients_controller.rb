class Admins::ClientsController < ApplicationController

  before_action :authenticate_admin!

  def index
    @clients = Client.page(params[:page])
  end
end
