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
        name: product.name
      }
    end
  end
end
