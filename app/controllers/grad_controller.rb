class GradController < ApplicationController

  get '/grads/signup' do
    if is_logged_in?(session)
      erb :'/grads/signup'
    else
      session[:message] = "You have to be signed in as an administrator to sign up."
      redirect to '/index'
    end
  end

  get '/grads/delete' do
    #binding.pry
    erb :'/grads/delete'
  end

  delete '/grads/delete' do

    grads =Grad.find(params['grads'])
    grads.each do |grad|
        grad.destroy
    end
    session[:message] = "Deleted successfully."
  #  binding.pry
    redirect to '/index'
  end

  post '/grads/signup' do
    grad1=Grad.create(params)

  #  binding.pry
    redirect to '/index'
  end

  get '/grads/:slug/edit' do
    if is_logged_in?(session)
      @grad = Grad.find_by_slug(params[:slug])

      erb :'/grads/edit'
    else
      session[:message] = "You have to be signed in as an administrator to edit."
    #  binding.pry
      redirect to '/index'
    end

  end

  patch '/grads/:slug' do
    @grad = Grad.find_by_slug(params[:slug])
    @grad.name= params[:name] unless params[:name]==""
    @gradtopic= params[:topic] unless params[:topic]==""
    @grad.save
    #binding.pry
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
