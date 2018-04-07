class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/index'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show'
    else
      redirect '/login'
    end

  end

  post '/tweets' do
    if logged_in?
      tweet = current_user.tweets.build(content: params[:content])
      if tweet.save
        redirect "/tweets/#{tweet.id}"
      else
        redirect '/tweets/new'
      end
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    erb :'tweets/edit'
  end

  patch '/tweets/:id' do

  end

end
