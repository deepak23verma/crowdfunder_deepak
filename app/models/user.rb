class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :first_name, :last_name, :email, :password
  has_many :projects
  has_many :pledges

  validates :first_name, :last_name, :password, :presence => true
  validates :email, uniqueness: {case_sensitive: false}
  # attr_accessible :title, :body
end
