class Person < ActiveRecord::Base

  belongs_to :institution, :class_name => "Federation"

  validates_uniqueness_of :name
  validates_uniqueness_of :email, :allow_nil => true

  before_create :set_default_mail

  private

  def set_default_mail
    if self.email.blank?
      
    end
  end

end
