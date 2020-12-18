RSpec.describe 'Merchants Business Intelligence API', type: :request do
  before :each do
    create_list(:merchant, 3, :with_revenue)

    @merchants_by_revenue = Merchant.all.sort_by(&:revenue).reverse
  end

  it 'can find merchants with the most revenue' do
    get '/api/v1/merchants/most_revenue?quantity=2'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchants.count).to eq(2)

    expect(merchants.first).to have_key(:id)
    expect(merchants.first[:id]).to be_an(String)

    expect(merchants.first[:attributes]).to have_key(:name)
    expect(merchants.first[:attributes][:name]).to be_a(String)
    expect(merchants.first[:attributes][:name]).to eq(@merchants_by_revenue.first.name)

    expect(merchants.second).to have_key(:id)
    expect(merchants.second[:id]).to be_an(String)

    expect(merchants.second[:attributes]).to have_key(:name)
    expect(merchants.second[:attributes][:name]).to be_a(String)
    expect(merchants.second[:attributes][:name]).to eq(@merchants_by_revenue.second.name)
  end
end
