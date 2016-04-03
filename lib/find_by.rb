class Module
  def create_finder_methods(*attributes)
    # Your code goes here!
    # Hint: Remember attr_reader and class_eval
    attributes.each do |attribute|
      define_method("find_by_#{attribute}") do |param|
        all.each do |product|
          if param.to_s == product.send(attribute)
            return product
          end
        end
      end
    end
  end
end
