class Phone < ActiveRecord::Base

  scope :sorted, -> { order(:name) }

  validates :name, presence: true
  validates :phone, presence: true

  def self.search(search)
    if search
      # Added ILIKE for Heroku(PostgreSQL). 
      # For SQLite, MySQL use LIKE
      where('name ILIKE ?', "%#{search}%")
    else
      all
    end
  end
end
