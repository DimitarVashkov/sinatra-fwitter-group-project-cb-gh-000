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

  post '/tweets' do
    # tweet = Tweet.new()
    tweet = current_user.tweets.build(content: params[:content])
    if tweet.save
      redirect "/tweets/#{tweet.id}"
    else
      redirect '/tweets/new'
    end

  end
end
