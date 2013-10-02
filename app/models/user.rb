class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :first_name, :last_name, :email, :password
  has_many :projects
  # attr_accessible :title, :body
end
