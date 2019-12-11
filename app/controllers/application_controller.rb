
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to "/articles"
  end

  get '/articles/new' do  # creates new articles
    erb :new
  end 

  get '/articles' do          #  grabs all articles
    @articles = Article.all   #   stores in an @inst_var 
    erb :index                # renders index.erb view, which iterates over @inst_var & renders on page
  end 

  post '/articles' do
    @article = Article.create(title: params[:title], content: params[:content])
    redirect "/articles/#{@article.id}"
  end

  get '/articles/:id' do   # grabs specific acticle
    @article = Article.find(params[:id])  # w/id that is in params and sets eq to @instance_of_that
    erb :show           #  renders show.erb page in view --> renders @article title & content
  end 

  get '/articles/:id/edit' do   # renders view --> edit.erb       its method="post"    NOT!!!!   method="PATCH"
    @article = Article.find(params[:id])                # contains form to update article & 
    erb :edit                #   POSTs to controller action via patch '/articles/:id'
  end 

  patch '/articles/:id' do
    # binding.pry
    @article = Article.find(params[:id])
    @article.update(params[:article])
    redirect to "/articles/#{@article.id}"
  end  

  delete "/articles/:id" do     # deletes article. button on SHOW.erb page. inside form.
    Article.destroy(params[:id])
    #   or
    # @article = Article.find_by_id(params[:id])
    # @article.delete
    redirect to "/articles"
  end

end