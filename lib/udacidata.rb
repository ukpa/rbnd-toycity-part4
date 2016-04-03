require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  # Your code goes here!

  @@data_path  = File.dirname(__FILE__) + "/../data/data.csv"
  Module.create_finder_methods(:name,:brand)
  def self.create(attributes = {})
    data = new(attributes)
    CSV.open(@@data_path, 'a') do |csv|
      csv << [data.id.to_s, data.brand, data.name, data.price]
    end
    data
  end

  def self.all
    csv = CSV.read(@@data_path).drop(1)
    csv.each_with_object([]) do |row,all_products|
      all_products << Product.new(id: row[0].to_i,brand: row[1],name: row[2],price: row[3].to_f)
    end
  end

  def self.first(val=nil)
    if val==nil
      return all.first
    else
      return all.take(val)
    end
  end

  def self.last(val=nil)
    if val==nil
      all.last
    else
      return all.slice(-val,val)
    end
  end

  def self.find(val)
    all.each {|product| return product if product.id == val}
    raise ProductNotFoundError, "The id: #{val} you are searching for doesn't exist"
  end

  def self.destroy(val)
    list = CSV.read(@@data_path)
    if val>list.length
      raise ProductNotFoundError, "The id: #{val} you are searching for doesn't exist"
    end

    destroyed_product = Product.new
    list.each do |product|
       if product[0]==val.to_s
         list.delete(product)
         destroyed_product = Product.new(id:product[0].to_i,brand:product[1], name:product[2],price:product[3].to_f)
       end
    end
    CSV.open(@@data_path, 'wb') do |csv|
      list.each do |product|
        csv << product
      end
    end
    destroyed_product
  end

  def self.where(option)
    all.each_with_object([]) do |data,set|
      set << data if data.send(option.keys.first)==option.values.first.to_s
    end
  end
  def update(options)
      list = CSV.read(@@data_path)
      list.each do |product|
        if product[0]==self.id.to_s
          options.each do |key, value|
            if key.to_s == "brand"
              product[1] = value
              self.send("#{key}=",value)
            elsif key.to_s =="name"
              product[2] = value
              self.send("#{key}=",value)
            elsif key.to_s =="price"
              product[3] = value.to_f
              self.send("#{key}=",value.to_f)
            end
          end
        end
      end
      CSV.open(@@data_path, 'wb') do |csv|
      list.each do |product|
        csv << product
      end
    end
    self
  end


end
