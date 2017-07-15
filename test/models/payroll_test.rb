require 'test_helper'

class PayrollTest < ActiveSupport::TestCase
  def test_end_date_validation
    payroll = Payroll.new start_period: 1.day.ago, end_period: 2.days.ago
    refute_predicate payroll, :valid?
    refute_empty payroll.errors[:end_period]
  end
end
