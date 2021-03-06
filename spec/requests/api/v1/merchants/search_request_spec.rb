RSpec.describe 'Search Merchants API', type: :request do
  describe '/find? endpoint' do
    it 'can find a merchant by exact attribute match' do
      merchant = create(:merchant)

      get "/api/v1/merchants/find?name=#{merchant.name}"

      expect(response).to be_successful

      merchant_result = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(merchant_result).to have_key(:id)
      expect(merchant_result[:id]).to eq(merchant.id.to_s)

      expect(merchant_result[:attributes]).to have_key(:name)
      expect(merchant_result[:attributes][:name]).to eq(merchant.name)
    end

    it 'can find a merchant by case-insensitive partial attribute match' do
      merchant = create(:merchant, name: "Wal-Mart")

      get "/api/v1/merchants/find?name=ARt"

      expect(response).to be_successful

      merchant_result = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(merchant_result).to have_key(:id)
      expect(merchant_result[:id]).to eq(merchant.id.to_s)

      expect(merchant_result[:attributes]).to have_key(:name)
      expect(merchant_result[:attributes][:name]).to eq(merchant.name)
    end

    it 'can find a merchant by date attribute match' do
      merchant = create(:merchant, created_at: 3.days.ago)

      get "/api/v1/merchants/find?created_at=#{merchant.created_at}"

      expect(response).to be_successful

      merchant_result = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(merchant_result).to have_key(:id)
      expect(merchant_result[:id]).to eq(merchant.id.to_s)

      expect(merchant_result[:attributes]).to have_key(:name)
      expect(merchant_result[:attributes][:name]).to eq(merchant.name)
    end
  end

  describe '/find_all? endpoint' do
    it 'can find all merchants by attribute' do
      create(:merchant, name: "Walgreens")
      create(:merchant, name: "Wal-Mart")
      create(:merchant, name: "Wally World")
      create(:merchant, name: "Outdoor World")

      get '/api/v1/merchants/find_all?name=wal'

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(merchants.count).to eq(3)

      merchants.each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_an(String)

        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
      end
    end
  end
end
