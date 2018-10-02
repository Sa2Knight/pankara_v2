module CONSTANT
  module FORMAT
    DATE = '%Y/%m/%d'.freeze
    DATE_TIME = '%Y-%m-%d %H:%M:%S'.freeze
  end
  module DEFAULT
    PAGE = 1
    PER_PAGE = 20
    SORT_KEY = 'id'.freeze
    SORT_ORDER = 'asc'.freeze
  end
  module CAP
    PER_PAGE = 100
  end
end
