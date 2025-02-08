require 'sinatra/base'
require 'json'
require 'byebug'
require_relative 'ledger'

module ExpenseTracker
  class API < Sinatra::Base
    def initialize(ledger: ExpenseTracker::Ledger.new)
      @ledger = ledger
      super()
    end

    post '/expenses' do
      request.body.rewind
      expense = JSON.parse(request.body.read)
      result = @ledger.record(expense)

      if result.success?
        JSON.generate('expense_id' => result.expense_id)

      else
        status 422
        JSON.generate('error' => result.error_message)
      end
    end

    get '/expenses/:date' do
      date = params[:date]
      expenses_on_date = @ledger.expenses_on(date)

      JSON.generate(expenses_on_date)
    end
  end
end
