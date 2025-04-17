RSpec::Matchers.define :have_no_tickets_sold do
  match { |event| event.tickets_sold.empty? }
  failure_message { |event| super() + " but #{event.tickets_sold.count} were sold" }
  failure_message_when_negated { |event| super() + " but no tickets were sold" }
end
