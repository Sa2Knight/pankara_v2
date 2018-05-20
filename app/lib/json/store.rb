module JSON
  module Store
    #
    # Storeモデルの属性のみ
    #
    def self.raw(store)
      return nil if store.blank?
      {
        id: store.id,
        branch: store.branch,
        name: store.name
      }
    end
  end
end
