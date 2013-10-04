class Pledge < ActiveRecord::Base
  attr_accessible :amount, :project_id, :user_id

  validates :project_id, :user_id, presence: true
  # validates :amount, numericality: true

  belongs_to :user
  belongs_to :project
end
