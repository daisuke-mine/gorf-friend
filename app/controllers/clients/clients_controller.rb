class Clients::ClientsController < ApplicationController

  def index
  end

  def show
    @client = Client.find(params[:id])

  end
  
  def edit
    @cliet = Client.find(params[:id])
    
  end
  
  def update
    @client = Client.find(params[:id])
    if @client.update(user_params)
      # flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@client.id)
    else
      render 'edit'
    end
  end
  
end
