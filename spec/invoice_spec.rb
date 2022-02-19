require 'spec_helper'

describe Invoice do
  before :each do
    # Reset db
    DbConnect.reset_db
  end

  describe "Check print invoice with tax" do
    it "no tax" do
      Product.new(id: 1, name: 'book', price: 10, imported: false, category: 'book').create
      InvoiceDetail.new(invoice: 'Invoice 1', product_id: 1, quantity: 2).create
      invoice = Invoice.new(invoice_name: "Invoice 1")
      invoice.print_receipt
      expect(invoice.instance_variable_get(:@total_price)).to eq 20
      expect(invoice.instance_variable_get(:@sales_taxs)).to eq 0
    end

    it "base tax" do
      Product.new(id: 1, name: 'music cd', price: 10, imported: false, category: 'others').create
      InvoiceDetail.new(invoice: 'Invoice 1', product_id: 1, quantity: 1).create
      invoice = Invoice.new(invoice_name: "Invoice 1")
      invoice.print_receipt
      expect(invoice.instance_variable_get(:@total_price)).to eq 11
      expect(invoice.instance_variable_get(:@sales_taxs)).to eq 1
    end

    it "imported duty tax" do
      Product.new(id: 1, name: 'imported book', price: 10, imported: true, category: 'food').create
      InvoiceDetail.new(invoice: 'Invoice 1', product_id: 1, quantity: 1).create
      invoice = Invoice.new(invoice_name: "Invoice 1")
      invoice.print_receipt
      expect(invoice.instance_variable_get(:@total_price)).to eq 10.5
      expect(invoice.instance_variable_get(:@sales_taxs)).to eq 0.5
    end

    it "imported duty tax with base tax" do
      Product.new(id: 1, name: 'imported bottle of perfume', price: 10, imported: true, category: 'others').create
      InvoiceDetail.new(invoice: 'Invoice 1', product_id: 1, quantity: 1).create
      invoice = Invoice.new(invoice_name: "Invoice 1")
      invoice.print_receipt
      expect(invoice.instance_variable_get(:@total_price)).to eq 11.5
      expect(invoice.instance_variable_get(:@sales_taxs)).to eq 1.5
    end
  end
end
