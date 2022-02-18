#!/usr/bin/ruby
require 'sqlite3'

module DbConnect
  def conn
    @db ||= SQLite3::Database.new "db/ruby_test.db"
    @db.results_as_hash = true
    @db
  end
  module_function :conn

  def reset_db
    begin
      # Products
      conn.execute("DROP TABLE IF EXISTS products;")
      conn.execute("CREATE TABLE 'products' (
          'id' integer PRIMARY KEY AUTOINCREMENT NOT NULL,
          'name' varchar,
          'category' varchar,
          'price' decimal(10,2) DEFAULT 0.0,
          `imported` boolean NOT NULL default 0
        )")

      # Invoice details
      conn.execute("DROP TABLE IF EXISTS invoice_details;")
      conn.execute("CREATE TABLE 'invoice_details' (
          'id' integer PRIMARY KEY AUTOINCREMENT NOT NULL,
          'invoice' varchar,
          'product' varchar,
          'category' varchar,
          'price' decimal(10,2) DEFAULT 0.0,
          'quantity' integer DEFAULT 0,
          `imported` boolean NOT NULL default 0
        )")
    rescue SQLite3::Exception => e
      puts "Exception occurred: #{e}"
    end
  end
  module_function :reset_db

  # create(name: 'abc', quantity: 2, price: 522)
  def insert(attrs = {})
    begin
      @attrs = attrs.empty? ? @attrs : attrs
      fields = @attrs.keys.join("', '")
      values = @attrs.values.join("', '")
      conn.execute("INSERT INTO #{self.table_name} ('#{fields}') VALUES ('#{values}')")
    rescue SQLite3::Exception => e
      puts "Exception occurred: #{e}"
    end
  end

  def update(id, **attrs)
    begin
      values = attrs.map{|k, v| "#{k} = '#{v}'"}.join(', ')
      conn.execute("UPDATE #{self.table_name} SET #{values} WHERE id = #{id};")
    rescue SQLite3::Exception => e
      puts "Exception occurred: #{e}"
    end
  end

  # fields: table field
  # options: query option (where/ limit ..)
  def select(*fields, **options)
    where = "WHERE #{options[:where]}" unless options[:where].nil?
    limit = "LIMIT #{options[:limit]}" unless options[:limit].nil?
    conn.execute("SELECT #{fields.join(', ')} FROM #{self.table_name} #{where} #{limit}")
  end

  def where(**attrs)
    condition = attrs.to_a.map{|k, v| "#{k} = '#{v}'"}.join(' AND ')
    conn.execute("SELECT * FROM #{self.table_name} WHERE #{condition}")
  end

  def all
    conn.execute("SELECT * FROM #{self.table_name}")
  end

  def find_by(**attrs)
    condition = attrs.to_a.map{|k, v| "#{k} = '#{v}'"}.join(' AND ')
    conn.execute("SELECT * FROM #{self.table_name} WHERE #{condition} LIMIT 1")&.first
  end
end
