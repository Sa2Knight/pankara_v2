module JSON
  module User
    def self.generate(user)
      return nil if user.blank?
      {
        id: user.id,
        display_name: user.display_name,
        image_url: user.image_url
      }
    end
  end
end
