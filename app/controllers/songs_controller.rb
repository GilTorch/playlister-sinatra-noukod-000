
class SongsController < ApplicationController

  use Rack::Flash

  get "/songs" do
    @songs=Song.all
    erb :"songs/index"
  end

  post "/songs" do
    @song=Song.create({name:@params[:song_name]})

    if !@params[:artist_name].nil?
      @song.artist=Artist.find_or_create_by({name:@params[:artist_name]})
    end
    #binding.pry
    @song.genres << Genre.find_or_create_by({name:@params[:genre_name]})
    @song.save
    flash[:message] = "Successfully created song."
    redirect :"/songs/#{@song.slug}"

  end

  get "/songs/new" do
    @genres=Genre.all
    erb :"songs/new"
  end

  get "/songs/:slug" do
    @song=Song.find_by_slug(@params[:slug])

    erb :"songs/show"
  end

  patch "/songs/:slug" do
    @song=Song.create({name:@params[:slug]})
    binding.pry
    @song.artist=Artist.create({name:@params[:artist_name]})
    @song.genres << Genre.create({name:@params[:genre_name]})
    @song.save
  end

  get "/songs/:slug/edit" do
    @song=Song.find_by_slug({name:@params[:slug]})
    erb :"songs/edit"
  end

end
