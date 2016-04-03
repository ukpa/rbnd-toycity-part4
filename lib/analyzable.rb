module Analyzable
  # Your code goes here!
  def average_price(list)
    total_products = list.length
    total_amount = 0
    list.each do |product|
      total_amount+=product.price
    end
    (total_amount/total_products).round(2)
  end

  def print_report(list)
    report = ""
    list.each do |product|
      report+="Id: #{product.id} | Brand: #{product.brand} | Product: #{product.name} | Price: #{product.price}\n"
    end
    report
  end

  def count_by_brand(list)
    hash ={}
    hash[list[0].brand]= list.length
    hash
  end

  def count_by_name(list)
    hash ={}
    hash[list[0].name]= list.length
    hash
  end
end
