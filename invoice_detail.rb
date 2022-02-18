require_relative 'db_connect'
require_relative 'libs/float'
require_relative 'libs/string'

class InvoiceDetail
  extend DbConnect

  attr_accessor :invoice, :product, :quantity

  def initialize(**attrs)
    @invoice = attrs[:invoice]
    @product = Product.find_by(id: attrs[:product_id])
    @quantity = attrs[:quantity]
    validate_attributes
  end

  def self.table_name
    @table_name ||= 'invoice_details'
  end

  def create
    params = {
      invoice: @invoice,
      quantity: @quantity,
      product: @product['name'],
      category: @product['category'],
      imported: @product['imported'],
      price: @product['price']
    }
    InvoiceDetail.insert(params)
  end

  private

  def validate_attributes
    # Check precense
    raise "Invoice must contain the value" if self.invoice.nil?
    raise "Product must contain the value" if self.product.nil?
    raise "Quantity must contain the value" if self.quantity.nil?
  end
end
