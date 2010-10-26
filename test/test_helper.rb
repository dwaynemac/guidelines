ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require File.expand_path(File.dirname(__FILE__) + "/blueprints")
require File.expand_path(File.dirname(__FILE__) + "/shoulda_macros")
require 'test_help'
require 'mocha'

class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
  setup do
    Sham.reset
    @user = User.find_or_create_by_drc_user("homer")
    if @user.padma.nil?
      @user.padma = PadmaToken.make(:user => @user)
      @user.save
    end
    DRCClient.mock_login("homer")
  end
end
