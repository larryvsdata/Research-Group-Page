class ProfessorController < ApplicationController
  get '/index' do
      #binding.pry
      @message = session[:message]
      erb :index
    end

    get '/login' do
      #binding.pry
      @message = session[:message]
      erb :'/professors/login'
    end

    get '/logout' do
      #binding.pry
      session.clear
      session[:message] = "Successfully logged out."
      redirect to '/login'
    end

    post '/login' do
      @professor= Professor.find_by(name: params[:name].strip)
      if @professor.authenticate(params[:password])
        session[:professor_id] = @professor.id
        session[:message] = "Successfully logged in."
      #  binding.pry
        redirect to '/index'
      else
        session[:message] = "Wrong username & password combination."
        redirect to '/login'
      end

    end

    get '/signup' do
    #  binding.pry
    if Professor.all.count < 1
        erb :'/professors/signup'
    else
      session[:message] = "Administrator already exists."
    #  binding.pry
      redirect to '/index'
    end
    end


    post '/signup' do
    #  binding.pry
      redirect to '/index' if params[:name].empty? || params[:topic].empty? || params[:password].empty?
      #user = User.create(username: params[:username] , email: params[:email] , password_digest: params[:password] )
    #  binding.pry
      professor =Professor.create(params)

    #  binding.pry
      session[:professor_id] = professor.id
      redirect to '/index'
    end

    get '/professors/:slug/edit' do
      if is_logged_in?(session)
        @professor = Professor.find_by_slug(params[:slug])
        erb :'/professors/edit'
      else
        session[:message] = "You have to be signed in as an administrator to edit."
      #  binding.pry
        redirect to '/index'
      end

    end

    patch '/professors/:slug' do
      @professor = Professor.find_by_slug(params[:slug])
      @professor.name= params[:name] unless params[:name]==""
      @professor.topic= params[:topic] unless params[:topic]==""
      @professor.password= params[:password] unless params[:password]==""
      @professor.save
      session[:message] = "Updated successfully."
      redirect to '/index'
    end


    helpers do
      def is_logged_in?(session)
        !!session[:professor_id]
      end
      def current_user(session)
        Professor.find(session[:professor_id])
      end
    end

end
