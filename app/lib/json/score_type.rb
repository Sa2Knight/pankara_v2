module JSON
  module ScoreType
    #
    # ScoreTypeモデルの属性のみ
    #
    def self.raw(score_type) return nil if score_type.blank?
      {
        id: score_type.id,
        brand: score_type.brand,
        name: score_type.name
      }
    end
  end
end
