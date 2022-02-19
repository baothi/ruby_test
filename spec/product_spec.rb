require 'spec_helper'

describe Product do
  before :each do
    DbConnect.reset_db
    Product.new(name: 'book', price: 12.49, imported: true, category: 'book').create
  end

  describe "#create" do
    it "return a new product record" do
      expect(Product.all.size).to eq 1
    end

    it "returns the correct attributes" do
      product = Product.find_by(name: 'book', price: 12.49, imported: true, category: 'book')
      expect(product.is_a?(Hash)).to eq true
    end

    context "#Validate attributes should contain the value" do
      it { expect { Product.new(price: 1, imported: true, category: 1) }.to raise_error('Name must contain the value') }
      it { expect { Product.new(name: '1', imported: true, category: 1) }.to raise_error('Price must contain the value') }
      it { expect { Product.new(name: '1', imported: true, category: 1, price: 1) }.to raise_error('Category: wrong allowable value') }
      it { expect { Product.new(name: '1', imported: '0', category: 'book', price: 1) }.to raise_error('Imported: wrong allowable value') }
    end
  end
end
