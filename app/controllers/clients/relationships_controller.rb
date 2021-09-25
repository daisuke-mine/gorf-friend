class Clients::RelationshipsController < ApplicationController

  # ——————フォロー機能を作成・保存・削除する————————————
  def create
    current_client.follow(params[:client_id])
    redirect_to request.referer
  end

  def destroy
    current_client.unfollow(params[:client_id])
    redirect_to request.referer
  end
#————————フォロー・フォロワー一覧を表示する-————————————
  def followings
    client = Client.find(params[:client_id])
    @client = client.followings
  end

  def followers
    client = Client.find(params[:client_id])
    @client = client.followers
  end
end
