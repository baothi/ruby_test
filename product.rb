require_relative 'db_connect'
require_relative 'libs/float'
require_relative 'libs/string'

class Product
  extend DbConnect

  attr_accessor :name, :imported, :price, :category

  def initialize(**attrs)
    @name = attrs[:name]
    @price = attrs[:price]
    @category = attrs[:category] # book, food, medical and others
    @imported = attrs[:imported] # boolean: detect product is imported goods
    @attrs = attrs
    validate_attributes
  end

  def self.table_name
    @table_name ||= 'products'
  end

  def create
    Product.insert(@attrs)
  end

  private

  def validate_attributes
    # Check precense
    raise "Name must contain the value" if self.name.nil?
    raise "Price must contain the value" if self.price.nil?

    # Check category
    unless self.category.to_s.in?('book', 'food', 'medical', 'others')
      raise "Category: wrong allowable value"
    end
    # Check imported
    unless self.imported.to_s.in?('true', 'false')
      raise "Imported: wrong allowable value"
    end
  end
end
