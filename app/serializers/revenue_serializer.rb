class RevenueSerializer
  def self.revenue(amount)
    {
      "data":
      {
        "id": nil,
        "attributes":
        {
          "revenue": amount.round(2)
        }
      }
    }
  end
end
