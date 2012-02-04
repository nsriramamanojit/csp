class Transaction < ActiveRecord::Base
      def self.search(search)
    if search
      where({:csp_code.matches => "%#{search}%"})
    else
      scoped
    end
  end
end
