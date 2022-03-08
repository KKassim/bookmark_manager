require 'sinatra/base'
require 'sinatra/reloader'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base
  enable :sessions, :method_override

  configure :development do
    register Sinatra::Reloader
  end

  get '/bookmarks' do
    # Print the ENV variable
    # p ENV
  
    @bookmarks = Bookmark.all
    erb :'bookmarks/index'
  end

  get '/bookmarks/new' do
    erb :'bookmarks/new'
  end

  post '/bookmarks' do
    Bookmark.create(url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    connection.exec_params("DELETE FROM bookmarks WHERE id = $1", [params[:id]])
    redirect '/bookmarks'
  end

  run! if app_file == $0
end
