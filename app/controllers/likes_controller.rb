class LikesController < ApplicationController
  def create
    @like = current_user.likes.build(micropost_id: params[:micropost_id])
    @like.save
    redirect_to :back
  end
  
  def destroy
    @like = current_user.likes.find_by(micropost_id: params[:id]) 
    @like.destroy
    redirect_to :back
  end
end
