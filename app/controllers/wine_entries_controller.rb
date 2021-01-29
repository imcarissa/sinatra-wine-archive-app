class WineEntriesController < ApplicationController

    # get wine_entries/new to render a form create a new entry
    get '/wine_entries/new' do
        erb :'/wine_entries/new'
    end

    # post wine_entries to create a new wine entry
    post '/wine_entries' do
        # I want to create a new wine entry and save it to the DB
        # I only want to save the entry if it has content
        if !logged_in?
            redirect '/'
        end
        # I want to create a wine entry if the user is logged in
        if params[:type] != ""
            # create a new entry
            @wine_entry = WineEntry.create(type: params[:type], user_id: current_user.id)
            redirect "/wine_entries/#{@wine_entry.id}"
        else
            redirect '/wine_entries/new'
        end
    end

    # show a route for a wine entry
    get '/wine_entries/:id' do
        @wine_entry = WineEntry.find(params[:id])
        erb :'/wine_entries/show'
    end

    # This route should send us to journal_entries/edit.erb
    # it renders an edit form
    get '/journal_entries/:id/edit' do
        @wine_entry = WineEntry.find(params[:id])
        erb :'/journal_entries/edit'
    end

    # index route for all wine entries


end