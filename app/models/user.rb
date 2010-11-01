class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.login_field = :drc_user
  end

  belongs_to :institution, :class_name => "Federation"

  ROLES = %W(federation_responsable federation_president supervisor admin)

  def allowed?
    self.authorized?
  end
end #end
