require_relative '../../../app/api'

require 'rack/test'

module ExpenseTracker
  RSpec.describe API do
    include Rack::Test::Methods

    def app
      API.new(ledger: ledger)
    end

    let (:ledger) { instance_double('ExpenseTracker::Ledger') }
    let (:parsed) { JSON.parse(last_response.body)}

    context 'when the expense is successfully recorded' do
      let (:expense) { { 'some' => 'data' } }

      before do
        allow(ledger).to receive(:record)
          .with(expense)
          .and_return(RecordResult.new(true, 417, nil))
      end

      it 'returns the expense id' do
        post '/expenses', JSON.generate(expense)

        expect(parsed).to include('expense_id' => 417)
      end

      it 'responds with a 200 OK' do
        post '/expenses', JSON.generate(expense)
        expect(last_response.status).to eq(200)
      end
    end

    context 'when the expense fails validation' do
      let (:expense) { { 'some' => 'data' } }

      before do
        allow(ledger).to receive(:record)
          .with(expense)
          .and_return(RecordResult.new(false, 417, 'Expense Incomplete'))
      end

      it 'returns an error message' do
        post '/expenses', JSON.generate(expense)

        expect(parsed).to include('error' => 'Expense Incomplete')
      end

      it 'responds with a 422 (Unprocessable entity)' do
        post '/expenses', JSON.generate(expense)
        expect(last_response.status).to eq(422)
      end
    end

    describe 'GET /expenses/:date' do
      let(:date) { '2025-01-15' }

      context 'when expenses exist on the given date' do
        let(:tea) do
          {
            'payee' => 'Starbucks',
            'amount' => 5.75,
            'date' => date
          }
        end

        before do
          allow(ledger).to receive(:expenses_on)
            .with(date)
            .and_return(tea)
        end

        it 'returns the expense records as JSON' do
          get "expenses/#{date}"

          expenses = JSON.parse(last_response.body)
          expect(expenses).to eq(tea)
        end

        it 'responds with a 200 (OK)' do
          get "expenses/#{date}"

          expect(last_response.status).to eq(200)
        end
      end

      context 'when there are no expenses on the given date' do
        before do
          allow(ledger).to receive(:expenses_on)
            .with(date)
            .and_return([])
        end

        it 'returns an empty array as JSON' do
          get "expenses/#{date}"

          expenses = JSON.parse(last_response.body)
          expect(expenses).to eq([])
        end

        it 'responds with a 200 (OK)' do
          get "expenses/#{date}"

          expect(last_response.status).to eq(200)
        end
      end
    end
  end
end
