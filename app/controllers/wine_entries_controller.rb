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
        if params[:wine_type] != ""
            @wine_entry = WineEntry.create(wine_type: params[:wine_type], user_id: current_user.id, wine_name: params[:wine_name], vintage: params[:vintage], region: params[:region], wine_notes: params[:wine_notes])
            flash[:message] = "Wine entry successfully created" if @wine_entry.id
            redirect "/wine_entries/#{@wine_entry.id}"
        else
            flash[:errors] = "Uh oh! Something went wrong. Please provide content for your entry."
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

   
    patch '/wine_entries/:id/' do
        redirect_if_not_logged_in
        set_wine_entry
        if authorized_to_edit?(wine_entry) && params[:wine_type] != ""
            @wine_entry.update(wine_type: params[:wine_type], user_id: current_user.id, wine_name: params[:wine_name], vintage: params[:vintage], region: params[:region], wine_notes: params[:wine_notes])
            redirect "/wine_entries/#{@wine_entry.id}"
        else
            redirect "users/#{current_id}"
        end
    end

    delete '/wine_entries/:id' do
        set_wine_entry
        if authorized_to_edit?(@wine_entry)
            @wine_entry.destroy
            flash[:message] = "Successfully deleted entry."
            redirect '/wine_entries'
        else
            redirect '/wine_entries'
        end
    end
    

    private
    
    def set_wine_entry
        @wine_entry = WineEntry.find(params[:id])
    end
    


end