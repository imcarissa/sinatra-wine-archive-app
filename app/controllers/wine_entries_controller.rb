class WineEntriesController < ApplicationController

    get '/wine_entries' do
        redirect_if_not_logged_in
        @wine_entries = WineEntry.all
        erb :'/wine_entries/index'
    end
    
    
    get '/wine_entries/new' do
        redirect_if_not_logged_in
        erb :'/wine_entries/new'
    end

    
    post '/wine_entries' do
        redirect_if_not_logged_in
        if params[:wine_name] !=""
            @wine_entry = WineEntry.create(wine_type: params[:wine_type], user_id: current_user.id, wine_name: params[:wine_name], vintage: params[:vintage], region: params[:region], wine_notes: params[:wine_notes])
            flash[:message] = "Wine entry successfully created" if @wine_entry.id
            redirect "/wine_entries/#{@wine_entry.id}"
        else
            flash[:errors] = "Uh oh! You can't have a blank entry. Please provide content for at least one of the spaces provided. You can edit the entry later."
            redirect '/wine_entries/new'
        end
    end

    
    get '/wine_entries/:id' do
        set_wine_entry
        erb :'/wine_entries/show'
    end


    get '/wine_entries/:id/edit' do
        redirect_if_not_logged_in
        set_wine_entry
        if authorized_to_edit?(@wine_entry)
            erb :'/wine_entries/edit'
        else
            redirect "users/#{current_user.id}"
        end   
    end

   
    patch '/wine_entries/:id' do
        redirect_if_not_logged_in
        set_wine_entry
        if authorized_to_edit?(@wine_entry) && params[:wine_name] != ""
            @wine_entry.update(wine_type: params[:wine_type], user_id: current_user.id, wine_name: params[:wine_name], vintage: params[:vintage], region: params[:region], wine_notes: params[:wine_notes])
            flash[:message] = "Successfully saved!"
            redirect "/wine_entries/#{@wine_entry.id}"
        else
            redirect "/users/#{current_user.id}"
        end
    end

    delete '/wine_entries/:id' do
        set_wine_entry
        if authorized_to_edit?(@wine_entry)
            @wine_entry.destroy
            flash[:message] = "Your entry as been deleted."
            redirect '/wine_entries'
        else
            redirect '/wine_entries/#{@wine_entry.id}'
        end
    end
    

    private
    
    def set_wine_entry
        @wine_entry = WineEntry.find_by(id: params[:id])
    end
    


end