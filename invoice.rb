require_relative 'libs/float'
require_relative 'libs/string'

class Invoice
  def initialize(**args)
    @name = args[:invoice_name]
    @invoice_details = InvoiceDetail.where(invoice: @name)
    @total_price = 0.0
    @sales_taxs = 0.0
  end

  def print_receipt
    puts "Quantity, Product, Price"
    @invoice_details.each do |ivd|
      @price = ivd['quantity'].to_f * ivd['price'].to_f
      item_tax = tax(ivd)
      item_price = @price + item_tax
      @sales_taxs += item_tax
      @total_price += item_price

      puts [ivd['quantity'], ivd['product'], item_price.round_005].join(", ")
    end
    puts "-----------------"
    puts "Sales Taxes: #{@sales_taxs.round_005}"
    puts "Total: #{@total_price.round_005}"
  end

  private

  def tax(invoice_detail)
    @invoice_detail = invoice_detail
    base_tax + imported_duty
  end

  def base_tax
    if @invoice_detail['category'].to_s.in?('others')
      (@price * 10 / 100).round_005
    else
      0
    end
  end

  def imported_duty
    if @invoice_detail['imported'].to_s == 'true'
      (@price * 5 / 100).round_005
    else
      0
    end
  end
end
