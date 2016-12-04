# frozen_string_literal: true

# MovlogAPP web service
class MovlogApp < Sinatra::Base
  get "/?" do
    slim :movie
  end

  get "/movie/:title/?" do
    movie_details = GetMovieDetails.call(params)
    if movie_details.success?
      movie_locations = movie_details.value
      @movie_details = MovieDetailsView.new(movie_locations)
      slim :movie_details
    else
      flash[:error] = 'Could not find that movie -- we are investigating!'
      redirect '/'
    end
  end

  get "/movie/?" do
    url_request = UrlRequest.call(params)
    results = FindMoviesFromDB.call(url_request)
    if results.success? && results.value.movies.count != 0
      @data = results.value
      puts @data
    else
      result = FindMoviesFromOMDB.call(url_request)
      if result.success?
        @data = result.value
      else
        flash[:error] = result.value.message
      end
      # flash[:error] = results.value.message
    end

    slim :movie
  end

  # get '/movie/?' do
  #   results = FindMoviesFromDB.call(params)
  #   if results.success?
  #     @data = results.value
  #   else
  #     flash[:error] = results.value.message
  #   end
  # end

  # post "/movie/?" do
  #   url_request = UrlRequest.call(params)
  #   result = FindMoviesFromOMDB.call(url_request)
  #   if result.success?
  #     @movie = result.value
  #   else
  #     flash[:error] = result.value.message
  #   end

    # redirect '/'
    # slim :movie
  # end
end
