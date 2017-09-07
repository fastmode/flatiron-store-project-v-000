class LineItemsController < ApplicationController

  def create
    item_number = params[:item_id]
    if current_user && current_user.current_cart
      current_user.current_cart.add_item(item_number)
    elsif current_user
      current_user.current_cart = current_user.carts.create
      current_user.current_cart.add_item(item_number).save
    end

    current_user.save
    redirect_to cart_path(current_user.current_cart)
  end
end
