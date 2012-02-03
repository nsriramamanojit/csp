class Account < ActiveRecord::Base

  validates :name, :presence => true, :length => { :maximum => 200}
  validates :csp_code, :presence => true, :uniqueness => true, :length => { :maximum => 20}


    def self.search(search)
    if search
      where({:name.matches => "%#{search}%"} | {:csp_code.matches => "%#{search}%"})
    else
      scoped
    end
  end
end
