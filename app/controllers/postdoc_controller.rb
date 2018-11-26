class PostdocController < ApplicationController

  get '/postdocs/signup' do
    if is_logged_in?(session)
      #binding.pry
      erb :'/postdocs/signup'
    else
      session[:message] = "You have to be signed in as an administrator to sign up."
      redirect to '/index'
    end
  end

  post '/postdocs/signup' do

    pd1=Postdoc.create(name: params[:name] , topic: params[:topic])
    professor1= Professor.find_by_id(session[:professor_id])
    pd1.professor = professor1
    grads =Grad.find(params['grads'])
    grads.each do |grad|
        pd1.grads << grad
    end
    pd1.save
    #binding.pry
    redirect to '/index'
  end

  get '/postdocs/:slug/edit' do
    if is_logged_in?(session)
      @pd = Postdoc.find_by_slug(params[:slug])
      #binding.pry
      erb :'/postdocs/edit'
    else
      session[:message] = "You have to be signed in as an administrator to edit."
    #  binding.pry
      redirect to '/index'
    end

  end

    patch '/postdocs/:slug' do
      #binding.pry
      pd1=Postdoc.find_by_slug(params[:slug])
      professor1= Professor.find_by_id(session[:professor_id])
      pd1.name= params[:name] unless params[:name]==""
      pd1.topic= params[:topic] unless params[:topic]==""
      pd1.professor = professor1
      grads =Grad.find(params['grads'])
      pd1.grads.clear
      grads.each do |grad|
          pd1.grads << grad
      end
      pd1.save
      #binding.pry
      redirect to '/index'

  end

  get '/postdocs/delete' do
    #binding.pry
    erb :'/postdocs/delete'
  end

  delete '/postdocs/delete' do
    pds =Postdoc.find(params['pds'])
    pds.each do |pd|
        pd.destroy
    end
    session[:message] = "Deleted successfully."
  #  binding.pry
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
