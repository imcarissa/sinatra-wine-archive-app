class UsersController < ApplicationController

    get "/login" do
        if logged_in?
          redirect "/users/#{current_user.id}"
        else
          erb :login
        end
      end
    


    post '/login' do
        @user = User.find_by(email: params[:email])
        if @user &&  @user.authenticate(params[:password])
            session[:user_id] = @user.id
            flash[:message] = "Welcome, #{@user.name}!"
            redirect "/users/#{@user.id}"
        else
            flash[:errors] = "Invalid input. Please put in the right credentials or sign up for an account to log in."
            redirect '/login'
        end
    end



    get '/signup' do
        erb :signup
    end



    post '/users' do
        @user = User.new(params)
        if @user.save 
            session[:user_id] = @user.id
            flash[:message] = "Successfully created account! Welcome, #{@user.name}!"
            redirect "/users/#{@user.id}"
        else
            flash[:errors] = "Failed to create account: #{@user.errors.full_messages.to_sentence}"
            redirect '/signup'
        end
    end
 


    get '/users/:id' do
        @user = User.find_by(id: params[:id])
        redirect_if_not_logged_in
        erb :'/users/show'
    end


    
    get '/logout' do
        session.clear 
        redirect '/'
    end

end