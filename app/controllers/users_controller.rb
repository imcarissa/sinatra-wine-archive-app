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
       
        if@user &&  @user.authenticate(params[:password])
            # log the user in - create user session
            session[:user_id] = @user.id
            # redirect to user landing page
            redirect "/users/#{@user.id}"
        else
            flash[:message] = "Invalid input. Please sign up to log in."
            # tell the user they entered invalid credentials
            # redirect to login page
            redirect '/login'
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
        # user to the DB
        # params will look like: 
        # {
        #    "name"=>"Liz",
        #   "email"=>"come@me.bro",
        #   "password"=>"pw1"
        # }
        # only persist a user with a name, email, and password
        if params[:name] != "" && params[:email] != "" && params[:password] != ""
            # valid input
            @user = User.create(params)
            # where do I go now?
            # navigate to the user show page
            redirect "/users/#{@user.id}"
        else
            # not valid input
            # include a message to user telling them what is wrong
            redirect '/signup'
        end
    end

    # user SHOW route
    get '/users/:id' do
        # what do I need to do first?
        @user = User.find_by(id: params[:id])
        session[:user_id] = @user.id
        erb :'/users/show'
    end

    get '/logout' do
        session.clear 
        redirect '/'
    end

end