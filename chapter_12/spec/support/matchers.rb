RSpec::Matchers.define :be_sold_out do
  match { |event| event.tickets_sold.count == event.capacity }
  failure_message { |event| super() + " but only #{event.tickets_sold.count} tickets were sold" }
  failure_message_when_negated { |event| super() + " but no tickets were sold" }
end

class HaveNoTicketsSold
  include RSpec::Matchers::Composable

  def matches?(event)
    @event = event
    event.tickets_sold.empty?
  end

  def description
    "have no tickets sold"
  end

  def failure_message
    "expected #{@event.inspect} to have no tickets sold" + failure_reason
  end

  def failure_message_when_negated
    "expected #{@event.inspect} to have tickets sold" + failure_reason
  end

  private

  def failure_reason
    if @event.tickets_sold.empty?
      " but it has no tickets sold"
    else
      " but it has #{@event.tickets_sold.count} tickets sold"
    end
  end
end

module EventMatchers
  def have_no_tickets_sold
    HaveNoTicketsSold.new
  end
end
