module JSON
  module User
    #
    # Userモデルの属性のみ
    #
    def self.raw(user)
      return nil if user.blank?
      {
        id: user.id,
        display_name: user.display_name,
        image_url: user.image_url
      }
    end
  end
end
