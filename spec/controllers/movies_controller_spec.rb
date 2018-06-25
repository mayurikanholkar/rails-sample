require 'rails_helper'

RSpec.describe MoviesController, type: :controller do 
  login_user
  
  before(:all) do 
    @movie = Movie.create(name: 'hello',photo:  Rack::Test::UploadedFile.new(File.open
          (File.join(Rails.root, '/app/assets/images/img2.jpeg')), 'image/jpeg'))
    @movie.save
  end  

  def find_movie(id)
    movie = Movie.find(id)
    return movie 
  end 

  describe "PUT #upvote" do
    it 'like the movie by logged in user' do
      movie = find_movie(@movie.id)
      movie.downvote_from @user
      expect(response.status).to eq 200
    end
  end 

  describe "PUT #downvote" do
    it 'unlike the movie by logged in user' do
      movie = find_movie(@movie.id)
      movie.downvote_from @user
      expect(response.status).to eq 200
    end
  end 
end