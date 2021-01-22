class UsersController < ApplicationController

    # what routes do I need for a login?

    # the purpose of this route is to render the login page/form
    get '/login' do
      
        erb :login 
    end


    # purpose of this route is to receive login form
    # find the user, log user in (create a session)
    post '/login' do
        # params looks like: {email: "user@user.com", password: "pw1"}
        # find user
        @user = User.find_by(email: params[:email])
        # authenticate user - veritfy who user says they are
        # they have the right email/password credentials
       
        if @user.authenticate(params[:password])
            # log the user in - create user session
            session[:user_id] = @user.id
            # redirect to user landing page
            redirect "/users/#{@user.id}"
        else
            # tell the user they entered invalid credentials
            # redirect to login page
        end
        # log the user in
        # redirect user to a landing page
    end

    # what routes do I need for signup?
    # this route's job is to render the sign up form
    get '/signup' do
        #  erb (render) a view
        erb :signup
    end

    post '/users' do
        # here is where we create a new user and persist to the database
    end

    # user SHOW route
    get '/users/:id' do
        "Welcome to Your Personal Wine Archive."
    end
end