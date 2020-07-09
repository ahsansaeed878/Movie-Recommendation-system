class MoviesController < ApplicationController

  # /movies/new?
  def new
    @movie = Movie.new(movie_params)

    if @movie.save
      if params[:genre].present?
        add_genre(params[:genre])
      end
      render json: @movie
    else
      render json: @movie.errors.messages
    end
  end

  # /movies/:id
  def update
    @movie = Movie.find_by(id: params[:id]) if params[:id].present?
    if @movie.present?
      @movie.update(movie_params)
      if params[:genre].present?
        add_genre(params[:genre])
      end
      render json: "Movie updated successfully!"
    else
      render json: "Movie not found!"
    end
  end

  # /movies/:id
  def destroy
    @movie = Movie.find_by(id: params[:id]) if params[:id].present?
    if @movie.present?
      @movie.destroy
      render json: "Movie deleted successfully!"
    else
      render json: "Movie not found!"
    end
  end

  # /movies/:id/add_genre?
  def add_genre(genres=nil)
    begin
      if params[:id].present? && genres.nil?
        @movie = Movie.find(params[:id])
        @genre = params[:genre].split(",")
        @genre.each do |gen|
          @movie.genres.create(name: gen)
        end
        render json: "Genres added successfully"
      elsif genres.present?
        @genre = genres.split(",")
        @genre.each do |gen|
          @movie.genres.create(name: gen)
        end
      end
    rescue Exception => e
      render json: e.message
    end
  end

  #handle like unlike functionality
  # /movies/:id/like?user_id
  def like
    if params[:id].present? && params[:user_id].present?
      @movie = Movie.find(params[:id])
      @user = User.find(params[:user_id])
      if @movie.present? && @user.present?
        if @movie.users.include?(@user)
          @like = Like.where(user_id: @user.id, movie_id: @movie.id).last
          @like.destroy
          render json: "You Unliked #{@movie.title}!"
        else
          @like = Like.create(movie: @movie, user: @user)
          render json: "You Liked #{@movie.title}!"
        end
      else
        render json: "False request!"
      end
    else
      render json: "Not enough parameters!"
    end
  end

  private

  def movie_params
    params.permit(:title, :year)
  end

end
