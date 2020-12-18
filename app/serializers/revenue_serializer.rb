class RevenueSerializer
  def self.revenue(amount)
    {
      "data":
      {
        "id": nil,
        "attributes":
        {
          "revenue": amount
        }
      }
    }
  end
end
