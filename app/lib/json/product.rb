module JSON
  module Product
    def self.generate(product)
      return nil if product.blank?
      {
        id: product.id,
        brand: product.brand,
        name: product.name
      }
    end
  end
end
