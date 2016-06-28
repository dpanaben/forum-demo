class Post < ActiveRecord::Base
  attr_accessible :title, :content, :avatar
  validates_presence_of :title

  belongs_to :board
  belongs_to :user

end
