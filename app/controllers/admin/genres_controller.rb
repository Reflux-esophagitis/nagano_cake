class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

  def index
    @genres = Genre.all
  end

  def edit
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      name = @genre.name
      redirect_to admin_genres_path, notice: "新しいジャンル「#{name}」を追加しました。"
    else
      @genres = Genre.all
      render :index
    end
  end

  def update
  end

  private
  def genre_params
    params.require(:genre).permit(:name)
  end
end
