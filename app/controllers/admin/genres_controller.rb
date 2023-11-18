class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_genre, only: %i[edit update]

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
    old_name = @genre.name

    if @genre.update(genre_params)
      new_name = @genre.name

      notice = updated_notice_text(old_name, new_name)
      redirect_to admin_genres_path, notice: notice
    else
      render :edit
    end
  end

  private
  def genre_params
    params.require(:genre).permit(:name)
  end

  def set_genre
    @genre = Genre.find(params[:id])
  end

  def updated_notice_text(old_name, new_name)
    if old_name != new_name
      "ジャンル名を「#{old_name}」から「#{new_name}」へ変更しました。"
    else
      "ジャンル名に変更はありませんでした。"
    end
  end
end
