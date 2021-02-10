require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "we_were_on_a_break"
    register Sinatra::Flash
  end


  get "/" do
    erb :welcome
  end

  get "/about" do
    erb :about
  end

  
  helpers do
    
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def authorized_to_edit?(wine_entry)
        @wine_entry.user == current_user
    end

    def redirect_if_not_logged_in
      if !logged_in?
        flash[:errors] = "You must be logged in to view the page."
        redirect '/'
      end
    end

  end 

  
end
