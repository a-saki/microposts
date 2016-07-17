class FavoritesController < ApplicationController
    def create
        @micropost = Micropost.find(params[:micropost_id])
        current_user.register_favorite(@micropost)
    end
    
    def destroy
        @micropost = Micropost.find_by(id: params[:micropost_id])
        current_user.destroy_favorite(@micropost)
    end
end
