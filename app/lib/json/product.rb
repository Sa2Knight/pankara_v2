module JSON
  module Product
    #
    # Productモデルの属性のみ
    #
    def self.raw(product)
      return nil if product.blank?
      {
        id: product.id,
        brand: product.brand,
        name: product.name,
        full_name: product.full_name
      }
    end
  end
end
