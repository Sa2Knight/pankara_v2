module JSON
  module Store
    def self.generate(store)
      return nil if store.blank?
      {
        id: store.id,
        branch: store.branch,
        name: store.name
      }
    end
  end
end
