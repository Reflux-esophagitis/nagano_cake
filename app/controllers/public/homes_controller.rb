class Public::HomesController < ApplicationController
  DISPLAY_NEW_ITEMS_COUNT = 4

  def top
    @new_items = Item.limit(DISPLAY_NEW_ITEMS_COUNT).recent_active_items_with_images
    @genres = Genre.all
  end

  def about
  end
end
