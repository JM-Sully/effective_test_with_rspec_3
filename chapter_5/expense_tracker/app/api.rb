require 'sinatra/base'
require 'json'
require 'byebug'

module ExpenseTracker
  class API < Sinatra::Base
    def initialize(ledger: Ledger.new)
      @ledger = ledger
      super()
    end

    class API < Sinatra::Base
      post '/expenses' do
        JSON.generate('expense_id' => 42)
      end

      get '/expenses/:date' do
        JSON.generate([])
      end
    end
  end
end
