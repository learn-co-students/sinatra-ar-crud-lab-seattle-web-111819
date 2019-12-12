
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect "/articles"
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  #FORM
  get '/articles/new' do
    erb :new
  end 

  #EDIT
  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end

  patch '/articles/:id' do
    @article = Article.find_by_id(params[:id])

    @article.update(params[:article])
    redirect to "/articles/#{@article.id}"
  end

  #CREATE---
  post '/articles' do
    #place code that extracts the form data from the params and uses it to create a new instance of your model class
   
    @article = Article.create(params[:article])
    # (:title => params[:title], :content => params[:content])

    redirect "/articles/#{@article.id}"
  end

  


  #showpage needs extra parameter (id)
  get '/articles/:id' do
    @article = Article.find(params["id"])
    erb :show
  end

  #READ---

  #UPDATE---

  #forms that delete and edit need to be submitted via (html) POST // controller = delete requests

  #DELETE---
  
  delete '/articles/:id' do
    #already in show page, no need for erb, same with update, create (post), only need for forms (create and update first part)

    @article = Article.find(params[:id])
    @article.delete
    redirect '/articles'
  end
end
