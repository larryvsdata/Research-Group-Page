require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret , "password"
  end

  get "/" do
  #  binding.pry
    erb :index
  end

end
