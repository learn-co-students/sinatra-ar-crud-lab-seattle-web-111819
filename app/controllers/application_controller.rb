
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  #home root page for Article class
  get '/' do
  end

  #index page
  get '/articles' do
    @articles = Article.all
    erb :index
  end

  #new article page
  get '/articles/new' do
    erb :new
  end
  
  #show page
  get '/articles/:id' do
    @article = Article.find_by_id(params[:id])
    erb :show
  end

  post '/articles' do
    # @article = Article.create(title: params[:title], content: params[:content])
    @article = Article.create(params)
    redirect to "/articles/#{@article.id}"
  end

  #load edit form
  get '/articles/:id/edit' do  
    @article = Article.find_by_id(params[:id])
    erb :edit
  end
 
  #edit action
  patch '/articles/:id' do 
    @article = Article.find_by_id(params[:id])
    @article.title = params[:title]
    @article.content = params[:content]
    @article.save
    redirect to "/articles/#{@article.id}"
  end

  #DELETE
  delete '/articles/:id' do
    @article = Article.find_by_id(params[:id])
    @article.delete
    redirect "/articles"
  end
  
end

