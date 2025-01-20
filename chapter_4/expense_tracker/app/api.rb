require 'sinatra/base'
require 'json'
require 'byebug'

module ExpenseTracker
  class API < Sinatra::Base
    def initialize
      @expenses = []
    end

    post '/expenses' do
      request.body.rewind
      expense = JSON.parse(request.body.read)
      expense['id'] = @expenses.size + 1
      @expenses << expense

      JSON.generate('expense_id' => expense['id'])
    end

    get '/expenses/:date' do
      date = params[:date]
      expenses_for_date = @expenses.select { |expense| expense['date'] == date }

      JSON.generate(expenses_for_date)
    end
  end
end
