class WineEntriesController < ApplicationController

    get '/wine_entries' do
        @wine_entries = WineEntry.all
        erb :'/wine_entries/index'
    end
    
    
    # get wine_entries/new to render a form create a new entry
    get '/wine_entries/new' do
        redirect_if_not_logged_in
        erb :'/wine_entries/new'
    end

    # post wine_entries to create a new wine entry
    post '/wine_entries' do
        # I want to create a new wine entry and save it to the DB
        # I only want to create a wine entry if the user is logged in
        redirect_if_not_logged_in
        # I only want to save the entry if it has content
        if params[:wine_type] != ""
            # create a new entry
            @wine_entry = WineEntry.create(wine_type: params[:wine_type], user_id: current_user.id)
            flash[:message] = "Wine entry successfully created" if @wine_entry.id
            redirect "/wine_entries/#{@wine_entry.id}"
        else
            flash[:errors] = "Uh oh! Something went wrong. Please provide content for your entry."
            redirect '/wine_entries/new'
        end
    end

    # show a route for a wine entry
    get '/wine_entries/:id' do
        set_wine_entry
        erb :'/wine_entries/show'
    end


    # ****** MAJOR PROBLEMS ******
    # RIGHT NOW, ANYONE CAN EDIT ANOTHER USER'S ENTRIES!!!
    # ALSO, I CAN EDIT AN ENTRY TO BE BLANK
    # This route should send us to wine_entries/edit.erb
    # it renders an edit form
    get '/wine_entries/:id/edit' do
        redirect_if_not_logged_in
        set_wine_entry
        if authorized_to_edit?(@wine_entry)
            erb :'/wine_entries/edit'
        else
            redirect "users/#{current_user.id}"
        end   
    end

    # This route... 
    patch '/wine_entries/:id/' do
    # 1. find wine entry
        redirect_if_not_logged_in
        set_wine_entry
        if authorized_to_edit?(wine_entry) && params[:wine_type] != ""
        # 2. modify(update) the entry
            @wine_entry.update(wine_type: params[:wine_type])
            # 3. redirect to show page
            redirect "/wine_entries/#{@wine_entry.id}"
        else
            redirect "users/#{current_id}"
        end
    end

    delete '/wine_entry/:id' do
        set_wine_entry
        if authorized_to_edit?(@wine_entry)
            @wine_entry.destroy
            flash[:message] = "Successfully deleted entry."
            redirect '/wine_entries'
        else
            redirect '/wine_entries'
        end
    end
    
    # index route for all wine entries

    private
    
    def set_wine_entry
        @wine_entry = WineEntry.find(params[:id])
    end
    


end