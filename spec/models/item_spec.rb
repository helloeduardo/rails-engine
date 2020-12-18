require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end

  describe 'class methods' do
    before :each do
      @item_1 = create(:item, name: 'Wal-Mart Shirt', created_at: '2020-12-16', updated_at: '2020-12-16')
      @item_2 = create(:item, name: 'Walgreens Mug', created_at: '2020-12-15', updated_at: '2020-12-15')
      @item_3 = create(:item, name: 'Outdoor World Hat', created_at: '2020-12-16', updated_at: '2020-12-16')
    end

    describe '#single_search' do
      it 'returns search result based on name' do
        expect(Item.single_search('name', @item_1.name)).to eq(@item_1)
      end

      it 'returns search result based on description' do
        expect(Item.single_search('description', @item_1.description)).to eq(@item_1)
      end

      it 'returns search result based on unit_price' do
        expect(Item.single_search('unit_price', @item_1.unit_price)).to eq(@item_1)
      end

      it 'returns search result based on partial search' do
        expect(Item.single_search('name', @item_1.name[2..-1])).to eq(@item_1)
      end

      it 'returns search result by case insensitive search' do
        expect(Item.single_search('name', @item_1.name.upcase)).to eq(@item_1)
      end

      it 'returns search result based on created_at' do
        expect(Item.single_search('created_at', '2020-12-16')).to eq(@item_1)
      end

      it 'returns search result based on updated_at' do
        expect(Item.single_search('updated_at', '2020-12-15')).to eq(@item_2)
      end
     end

    describe '#multi_search' do
      it 'returns search result based on name' do
        expect(Item.multi_search('name', 'Wal').count).to eq(2)
        expect(Item.multi_search('name', 'Wal')).to eq([@item_1, @item_2])
      end

      it 'returns search result based on description' do
        expect(Item.multi_search('description', @item_1.description).count).to eq(1)
        expect(Item.multi_search('description', @item_1.description)).to eq([@item_1])
      end

      it 'returns search result based on unit_price' do
        expect(Item.multi_search('unit_price', @item_2.unit_price).count).to eq(1)
        expect(Item.multi_search('unit_price', @item_2.unit_price)).to eq([@item_2])
      end

      it 'returns search result based on partial search' do
        expect(Item.multi_search('name', 'Wa').count).to eq(2)
        expect(Item.multi_search('name', 'Wa')).to eq([@item_1, @item_2])
      end

      it 'returns search result by case insensitive search' do
        expect(Item.multi_search('name', 'WAL').count).to eq(2)
        expect(Item.multi_search('name', 'WAL')).to eq([@item_1, @item_2])
      end

      it 'returns search result based on created_at' do
        expect(Item.multi_search('created_at', '2020-12-16').count).to eq(2)
        expect(Item.multi_search('created_at', '2020-12-16')).to eq([@item_1, @item_3])
      end

      it 'returns search result based on updated_at' do
        expect(Item.multi_search('updated_at', '2020-12-15').count).to eq(1)
        expect(Item.multi_search('updated_at', '2020-12-15')).to eq([@item_2])
      end
    end
  end
end
