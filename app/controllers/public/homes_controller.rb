class Public::HomesController < ApplicationController
  DISPLAY_NEW_ITEMS_COUNT = 4

  def top
    @new_items = Item.active.order(created_at: :desc).limit(DISPLAY_NEW_ITEMS_COUNT)
    @genres = Genre.all
  end

  def about
  end
end
