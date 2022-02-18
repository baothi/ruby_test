require_relative 'db_connect'
require_relative 'product'
require_relative 'invoice_detail'
require_relative 'invoice'

# Reset db
DbConnect.reset_db

## Input 1
Product.new(id: 11, name: 'book', price: 12.49, imported: false, category: 'book').create
Product.new(id: 12, name: 'music cd', price: 14.99, imported: false, category: 'others').create
Product.new(id: 13, name: 'chocolate bar', price: 0.85, imported: false, category: 'food').create
InvoiceDetail.new(invoice: 'Invoice 1', product_id: 11, quantity: 1).create
InvoiceDetail.new(invoice: 'Invoice 1', product_id: 12, quantity: 1).create
InvoiceDetail.new(invoice: 'Invoice 1', product_id: 13, quantity: 1).create

## Input 2
Product.new(id: 21, name: 'Imported box of chocolates', price: 10.00, imported: true, category: 'food').create
Product.new(id: 22, name: 'imported bottle of perfume', price: 47.50, imported: true, category: 'others').create
InvoiceDetail.new(invoice: 'Invoice 2', product_id: 21, quantity: 1).create
InvoiceDetail.new(invoice: 'Invoice 2', product_id: 22, quantity: 1).create

## Input 3
Product.new(id: 31, name: 'imported bottle of perfume', price: 27.99, imported: true, category: 'others').create
Product.new(id: 32, name: 'bottle of perfume', price: 18.99, imported: false, category: 'others').create
Product.new(id: 33, name: 'packet of headache pills', price: 9.75, imported: false, category: 'medical').create
Product.new(id: 34, name: 'box of imported chocolates', price: 11.25, imported: true, category: 'food').create
InvoiceDetail.new(invoice: 'Invoice 3', product_id: 31, quantity: 1).create
InvoiceDetail.new(invoice: 'Invoice 3', product_id: 32, quantity: 1).create
InvoiceDetail.new(invoice: 'Invoice 3', product_id: 33, quantity: 1).create
InvoiceDetail.new(invoice: 'Invoice 3', product_id: 34, quantity: 1).create

# Print receipt
puts
puts '==========#####========='
puts "## Output 1"
Invoice.new(invoice_name: "Invoice 1").print_receipt

puts
puts '==========#####========='
puts "## Output 2"
Invoice.new(invoice_name: "Invoice 2").print_receipt

puts
puts '==========#####========='
puts "## Output 3"
Invoice.new(invoice_name: "Invoice 3").print_receipt
