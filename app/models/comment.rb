class Comment < ActiveRecord::Base

  belongs_to :commentable, :polymorphic => true
  belongs_to :user

  validates_presence_of :body

  def commentor_name
    self.user.drc_user.split('.').map{|t|t.capitalize}.join(' ')
  end

  # @return true if Comment was modified after creation.
  def updated?
    time_tolerance = 2.minutes
    return (self.created_at+time_tolerance < self.updated_at)
  end
end
