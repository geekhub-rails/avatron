class Avatar < ApplicationRecord
  def resize_image(size)
    self.url.sub(/\/upload\//, "/upload/w_#{size},h_#{size}/")
  end
end
