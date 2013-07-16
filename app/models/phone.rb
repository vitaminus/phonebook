class Phone < ActiveRecord::Base

  validates :name, presence: true
  validates :phone, presence: true

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      all
    end
  end
end
