RSpec.describe 'Merchants Business Intelligence API', type: :request do
  before :each do
    create_list(:merchant, 3, :with_revenue)
  end

  it 'can find merchants with the most revenue' do
    merchants_by_revenue = Merchant.all.sort_by(&:revenue).reverse

    get '/api/v1/merchants/most_revenue?quantity=2'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchants.count).to eq(2)

    expect(merchants.first).to have_key(:id)
    expect(merchants.first[:id]).to be_an(String)

    expect(merchants.first[:attributes]).to have_key(:name)
    expect(merchants.first[:attributes][:name]).to be_a(String)
    expect(merchants.first[:attributes][:name]).to eq(merchants_by_revenue.first.name)

    expect(merchants.second).to have_key(:id)
    expect(merchants.second[:id]).to be_an(String)

    expect(merchants.second[:attributes]).to have_key(:name)
    expect(merchants.second[:attributes][:name]).to be_a(String)
    expect(merchants.second[:attributes][:name]).to eq(merchants_by_revenue.second.name)
  end

  it 'can find merchants with the most items sold' do
    merchant_1 = create(:merchant, :with_revenue, items_per_invoice: 5)
    merchant_2 = create(:merchant, :with_revenue, items_per_invoice: 4)

    get '/api/v1/merchants/most_items?quantity=2'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchants.count).to eq(2)

    expect(merchants.first).to have_key(:id)
    expect(merchants.first[:id]).to be_an(String)

    expect(merchants.first[:attributes]).to have_key(:name)
    expect(merchants.first[:attributes][:name]).to be_a(String)
    expect(merchants.first[:attributes][:name]).to eq(merchant_1.name)

    expect(merchants.second).to have_key(:id)
    expect(merchants.second[:id]).to be_an(String)

    expect(merchants.second[:attributes]).to have_key(:name)
    expect(merchants.second[:attributes][:name]).to be_a(String)
    expect(merchants.second[:attributes][:name]).to eq(merchant_2.name)
  end
end
