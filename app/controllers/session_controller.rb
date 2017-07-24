class SessionController < ApplicationController
    
    def new
        id = session[:user_id]
        user = User.find_by_id(id)
        if id.nil?
            render 'new'
        else
            return redirect_to users_controller # routes to users#index
        end
    end
    
    
    
end