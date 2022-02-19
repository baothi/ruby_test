require 'spec_helper'

describe DbConnect do
  before :each do
    DbConnect.reset_db
    Product.insert(name: 'book', price: 12.49, imported: 1, category: 'book')
    @product = Product.find_by(name: 'book')
  end

  describe "#insert data" do
    it "Insert success record" do
      expect(Product.all.size).to eq 1
    end
  end

  describe "#Update data" do
    it "update success record" do
      Product.update(@product['id'], name: 'book1')
      expect(Product.find_by(name: 'book1').is_a?(Hash)).to be_truthy
    end
  end

  describe "#Select items" do
    it "select attributes without condition" do
      expect(Product.select(:category)).to match_array [{"category"=>"book"}]
    end

    context "select attributes with condition" do
      it { expect(Product.select(:category, where: "category = 'book'")).to match_array [{"category"=>"book"}] }
      it { expect(Product.select(:category, where: "category = 'book1'")).to match_array [] }
    end

    it "select all records" do
      Product.insert(name: 'book2', price: 12.49, imported: 1, category: 'book')
      expect(Product.all.size).to eq 2
    end

    it "where records" do
      Product.where(name: 'book')
      expect(Product.where(name: 'book').is_a?(Array)).to be_truthy
      expect(Product.where(name: 'book').size).to eq 1
    end
  end

  describe "#Find an item" do
    it { expect(Product.find_by(name: 'book').is_a?(Hash)).to be_truthy }
  end
end
