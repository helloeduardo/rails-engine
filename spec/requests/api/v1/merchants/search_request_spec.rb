RSpec.describe 'Search Merchants API', type: :request do
  it 'can find a merchant by exact attribute match' do
    create_list(:merchant, 3)

    merchant = Merchant.last

    get "/api/v1/merchants/find?name=#{merchant.name}"

    expect(response).to be_successful

    merchant_result = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchant_result).to have_key(:id)
    expect(merchant_result[:id]).to eq(merchant.id.to_s)

    expect(merchant_result[:attributes]).to have_key(:name)
    expect(merchant_result[:attributes][:name]).to eq(merchant.name)
  end

  it 'can find a merchant by case-insensitive partial attribute match' do
    create_list(:merchant, 3)

    merchant = create(:merchant, name: "Wal-Mart")

    get "/api/v1/merchants/find?name=ARt"

    expect(response).to be_successful

    merchant_result = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchant_result).to have_key(:id)
    expect(merchant_result[:id]).to eq(merchant.id.to_s)

    expect(merchant_result[:attributes]).to have_key(:name)
    expect(merchant_result[:attributes][:name]).to eq(merchant.name)
  end

  xit 'can find all merchants by attribute' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

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
