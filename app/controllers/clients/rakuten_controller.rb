class Clients::RakutenController < ApplicationController
  
  before_action :authenticate_client!
  
  def search
    if params[:keyword]
      @golf_courses = RakutenWebService::Gora::Course.search(keyword: params[:keyword], sort: "rating" )

    end

  end
end
