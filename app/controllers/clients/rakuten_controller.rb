class Clients::RakutenController < ApplicationController


  def search
    if params[:keyword]
      @golf_courses = RakutenWebService::Gora::Course.search(keyword: params[:keyword], sort: "rating" )
    end

  end
end
