require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :invoices }
    it { should have_many :items }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'class methods' do
    before :each do
      @merchant_1 = create(:merchant, name: 'Wal-Mart', created_at: '2020-12-16', updated_at: '2020-12-16')
      @merchant_2 = create(:merchant, name: 'Walgreens', created_at: '2020-12-15', updated_at: '2020-12-15')
      @merchant_3 = create(:merchant, name: 'Outdoor World', created_at: '2020-12-16', updated_at: '2020-12-16')
    end

    describe '#single_search' do
      it 'returns search result based on name' do
        expect(Merchant.single_search('name', @merchant_1.name)).to eq(@merchant_1)
      end

      it 'returns search result based on partial search' do
        expect(Merchant.single_search('name', @merchant_1.name[2..-1])).to eq(@merchant_1)
      end

      it 'returns search result by case insensitive search' do
        expect(Merchant.single_search('name', @merchant_1.name.upcase)).to eq(@merchant_1)
      end

      it 'returns search result based on created_at' do
        expect(Merchant.single_search('created_at', '2020-12-16')).to eq(@merchant_1)
      end

      it 'returns search result based on updated_at' do
        expect(Merchant.single_search('updated_at', '2020-12-15')).to eq(@merchant_2)
      end
     end

    describe '#multi_search' do
      it 'returns search result based on name' do
        expect(Merchant.multi_search('name', 'Wal').count).to eq(2)
        expect(Merchant.multi_search('name', 'Wal')).to eq([@merchant_1, @merchant_2])
      end

      it 'returns search result based on partial search' do
        expect(Merchant.multi_search('name', 'Wa').count).to eq(2)
        expect(Merchant.multi_search('name', 'Wa')).to eq([@merchant_1, @merchant_2])
      end

      it 'returns search result by case insensitive search' do
        expect(Merchant.multi_search('name', 'WAL').count).to eq(2)
        expect(Merchant.multi_search('name', 'WAL')).to eq([@merchant_1, @merchant_2])
      end

      it 'returns search result based on created_at' do
        expect(Merchant.multi_search('created_at', '2020-12-16').count).to eq(2)
        expect(Merchant.multi_search('created_at', '2020-12-16')).to eq([@merchant_1, @merchant_3])
      end

      it 'returns search result based on updated_at' do
        expect(Merchant.multi_search('updated_at', '2020-12-15').count).to eq(1)
        expect(Merchant.multi_search('updated_at', '2020-12-15')).to eq([@merchant_2])
      end
    end
  end
end
