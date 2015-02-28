class Recipe < ActiveRecord::Base
    
  belongs_to :user

  validates :name, :presence => true
  validates :description, :presence => true

  scope :visible, lambda { where(:visible => true) }
  scope :invisible, lambda { where(:visible => false) }
end
