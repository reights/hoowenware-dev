class EntityMetasController < ApplicationController

  

  private
    def meta_params
      params.require(:entity_meta).permit(:entity_id, :entity_type, :meta_type, :data,
                                          :user_id, :trip_id, :group_id)
    end

    def set_user
      @user = User.find(params[:id])
   rescue ActiveRecord::RecordNotFound
     flash[:alert] = "The profile you were looking for could not be found."
     redirect_to root_path
    end

    def set_trip
      @trip = Trip.find(params[:id])
   rescue ActiveRecord::RecordNotFound
     flash[:alert] = "The trip you were looking for could not be found."
     redirect_to trips_path
    end

    def set_group
      @group = Group.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The group you were looking for could not be found."
      redirect_to groups_path
    end
end
