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

    describe '#most_revenue' do
      it 'returns a number of merchants with the highest revenue' do
        merchants = create_list(:merchant, 3, :with_revenue)
        merchants_by_revenue = merchants.sort_by(&:revenue).reverse

        expect(Merchant.most_revenue(1)).to eq(merchants_by_revenue.first(1))
        expect(Merchant.most_revenue(2)).to eq(merchants_by_revenue.first(2))
      end
    end

    describe '#most_items' do
      it 'returns a number of merchants with the highest amount of items' do
        merchant_1 = create(:merchant, :with_revenue, items_per_invoice: 5)
        merchant_2 = create(:merchant, :with_revenue, items_per_invoice: 4)

        expect(Merchant.most_items(1)).to eq([merchant_1])
        expect(Merchant.most_items(2)).to eq([merchant_1, merchant_2])
      end
    end

    describe '#total_revenue_between_dates' do
      it 'returns total revenue for all merchants between dates' do
        merchants = create_list(:merchant, 2, :with_revenue, creation: (DateTime.now - 5.days))
        start_date = Date.today - 7
        end_date = Date.today - 2
        total_revenue_between_dates = merchants.sum(&:revenue).round(2)

        expect(Merchant.total_revenue_between_dates(start_date, end_date)).to eq(total_revenue_between_dates)
      end
    end
  end

  describe 'instance methods' do
    describe '#revenue' do
      it "returns total revenue for a merchant" do
        merchant = create(:merchant, :with_revenue)

        revenue = merchant.invoices.sum do |invoice|
          invoice.invoice_items.sum do |invoice_item|
            invoice_item.quantity * invoice_item.unit_price
          end
        end.round(2)

        expect(merchant.revenue).to eq(revenue)
      end
    end
  end
end
