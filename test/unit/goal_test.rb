require 'test_helper'

class GoalTest < ActiveSupport::TestCase
  context "" do
    setup do
      @parent = Factory(:goal)
      10.times{Factory(:goal, :value => 1, :control_item => "students", :goal => @parent)}
      2.times{Factory(:goal, :value => 3, :control_item => "enrollments", :goal => @parent)}
    end
    should "have implicit goals: 10 students and 6 enrollments" do
      assert_equal({"students" => 10, "enrollments" => 6}, @parent.implicit_goals)
    end
  end
end
