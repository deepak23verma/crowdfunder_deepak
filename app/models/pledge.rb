class Pledge < ActiveRecord::Base
  attr_accessible :amount, :project_id, :user_id

  validates :user_id, :project_id, presence: true
  validates :amount, numericality: {greater_than: 0, only_integer: true}

  belongs_to :user
  belongs_to :project
end
