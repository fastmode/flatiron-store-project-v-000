class Cart < ActiveRecord::Base
  has_many :line_items
  has_many :items, through: :line_items
  belongs_to :user

  def total
    self.line_items.collect { |line_item| line_item.item.price * line_item.quantity }.sum
  end 

  def add_item(new_item)
    if line_item = self.line_items.find_by(item_id: new_item)
      line_item.update(quantity: line_item.quantity + 1)
      line_item 
    else      
      self.line_items.build(item_id: new_item)
    end
  end

  

end
