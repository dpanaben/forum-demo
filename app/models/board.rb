class Board < ActiveRecord::Base
  attr_accessible :name
  has_many :posts

  validates_presence_of :name

  #default_scope :order => "created_at DESC"
end
