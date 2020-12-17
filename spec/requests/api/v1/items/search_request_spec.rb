RSpec.describe 'Search Items API', type: :request do
  describe '/find? endpoint' do
    it 'can find a item by exact attribute match' do
      item = create(:item)

      get "/api/v1/items/find?name=#{item.name}"

      expect(response).to be_successful

      item_result = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(item_result).to have_key(:id)
      expect(item_result[:id]).to eq(item.id.to_s)

      expect(item_result[:attributes]).to have_key(:name)
      expect(item_result[:attributes][:name]).to eq(item.name)

      expect(item_result[:attributes]).to have_key(:description)
      expect(item_result[:attributes][:description]).to eq(item.description)

      expect(item_result[:attributes]).to have_key(:unit_price)
      expect(item_result[:attributes][:unit_price]).to eq(item.unit_price)
    end

    it 'can find a item by unit_price match' do
      item = create(:item)

      get "/api/v1/items/find?unit_price=#{item.unit_price}"

      expect(response).to be_successful

      item_result = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(item_result).to have_key(:id)
      expect(item_result[:id]).to eq(item.id.to_s)

      expect(item_result[:attributes]).to have_key(:name)
      expect(item_result[:attributes][:name]).to eq(item.name)

      expect(item_result[:attributes]).to have_key(:description)
      expect(item_result[:attributes][:description]).to eq(item.description)

      expect(item_result[:attributes]).to have_key(:unit_price)
      expect(item_result[:attributes][:unit_price]).to eq(item.unit_price)
    end

    it 'can find a item by case-insensitive partial attribute match' do
      item = create(:item, name: "Wal-Mart Shirt")

      get "/api/v1/items/find?name=ARt"

      expect(response).to be_successful

      item_result = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(item_result).to have_key(:id)
      expect(item_result[:id]).to eq(item.id.to_s)

      expect(item_result[:attributes]).to have_key(:name)
      expect(item_result[:attributes][:name]).to eq(item.name)

      expect(item_result[:attributes]).to have_key(:description)
      expect(item_result[:attributes][:description]).to eq(item.description)

      expect(item_result[:attributes]).to have_key(:unit_price)
      expect(item_result[:attributes][:unit_price]).to eq(item.unit_price)
    end

    it 'can find a item by date attribute match' do
      item = create(:item, created_at: 3.days.ago)

      get "/api/v1/items/find?created_at=#{item.created_at}"

      expect(response).to be_successful

      item_result = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(item_result).to have_key(:id)
      expect(item_result[:id]).to eq(item.id.to_s)

      expect(item_result[:attributes]).to have_key(:name)
      expect(item_result[:attributes][:name]).to eq(item.name)

      expect(item_result[:attributes]).to have_key(:description)
      expect(item_result[:attributes][:description]).to eq(item.description)

      expect(item_result[:attributes]).to have_key(:unit_price)
      expect(item_result[:attributes][:unit_price]).to eq(item.unit_price)
    end
  end

  describe '/find_all? endpoint' do
    it 'can find all items by attribute' do
      create(:item, name: "Walgreens Shirt")
      create(:item, name: "Wal-Mart Shirt")
      create(:item, name: "Wally World Mug")
      create(:item, name: "Outdoor World Mug")

      get '/api/v1/items/find_all?name=wal'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(items.count).to eq(3)

      items.each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(String)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)
      end
    end
  end
end
