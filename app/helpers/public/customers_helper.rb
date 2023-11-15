module Public::CustomersHelper

  def full_name
    self.last_name + self.first_name
  end

end
