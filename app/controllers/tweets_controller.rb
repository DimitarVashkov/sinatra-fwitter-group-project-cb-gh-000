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
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        if @tweet.update(content: params[:content])
          redirect "/tweets/#{@tweet.id}"
        else
          redirect "/tweets/#{@tweet.id}/edit"
        end
      else
        redirect '/tweets'
      end
    else
      redirect to '/login'
    end

  end

  delete '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user == current_user
        @tweet.delete
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

end
