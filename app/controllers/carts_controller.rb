class CartsController < ApplicationController

  def show
    @current_cart = current_user.current_cart
    # @current_cart = Cart.find_by(id: params[:id])
    render 'carts/checkout' if @current_cart.status == "submitted"
  end

  def checkout
    @user = current_user
    @user.update(current_cart: nil)

    @current_cart = Cart.find_by(params[:id])
    @current_cart.update(status: "submitted")
    
    #Updates inventory
    @current_cart.line_items.each do |line_item|
      line_item.item.update(inventory: line_item.item.inventory - line_item.quantity)
    end

    redirect_to cart_path(@current_cart)
  end  

end
