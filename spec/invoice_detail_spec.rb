require 'spec_helper'

describe InvoiceDetail do
  before :each do
    DbConnect.reset_db
    Product.new(id: 1, name: 'book', price: 12.49, imported: true, category: 'book').create
    InvoiceDetail.new(invoice: 'invoice 1', product_id: 1, quantity: 1).create
  end

  describe "#create" do
    it "return a new product record" do
      expect(InvoiceDetail.all.size).to eq 1
    end

    context "#Validate attributes should contain the value" do
      it { expect { InvoiceDetail.new(product_id: 1, quantity: 1) }.to raise_error('Invoice must contain the value') }
      it { expect { InvoiceDetail.new(invoice: 'invoice 1', quantity: 1) }.to raise_error('Product must contain the value') }
      it { expect { InvoiceDetail.new(invoice: 'invoice 1', product_id: 1) }.to raise_error('Quantity must contain the value') }
    end
  end
end
