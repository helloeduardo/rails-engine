RSpec.describe 'Items API', type: :request do
  it 'can get items' do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(items.count).to eq(3)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_an(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
    end
  end

  it 'can show a item' do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(item).to have_key(:id)
    expect(item[:id]).to be_an(String)

    expect(item[:attributes]).to have_key(:name)
    expect(item[:attributes][:name]).to be_a(String)

    expect(item[:attributes]).to have_key(:description)
    expect(item[:attributes][:description]).to be_an(String)

    expect(item[:attributes]).to have_key(:unit_price)
    expect(item[:attributes][:unit_price]).to be_a(Float)
  end

  it "can create a item" do
    merchant = create(:merchant)
    item_params = {
      name: 'iPhone 12',
      description: 'Another iPhone!',
      unit_price: 699.99,
      merchant_id: merchant.id
    }
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item_params)
    created_item = Item.last

    expect(response).to be_successful
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end

  it "can update a item" do
    id = create(:item).id
    previous_name = Item.last.name
    item_params = { name: 'Enameled Plant Pot' }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate(item_params)
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq(item_params[:name])
  end

  it "can destroy a item" do
    item = create(:item)

    expect(Item.count).to eq(1)

    expect{ delete "/api/v1/items/#{item.id}" }.to change(Item, :count).by(-1)

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "can get merchant an item belongs to" do
    id = create(:item).id

    get "/api/v1/items/#{id}/merchants"

    expect(response).to be_successful

    item_merchant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(item_merchant).to have_key(:id)
    expect(item_merchant[:id]).to be_an(String)

    expect(item_merchant).to have_key(:type)
    expect(item_merchant[:type]).to eq("merchant")

    expect(item_merchant).to have_key(:attributes)
    expect(item_merchant[:attributes]).to be_a(Hash)

    expect(item_merchant[:attributes]).to have_key(:name)
    expect(item_merchant[:attributes][:name]).to be_an(String)
  end
end
