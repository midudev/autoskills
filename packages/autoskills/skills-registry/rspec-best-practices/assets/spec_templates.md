# RSpec Best Practices — Spec Templates

Purpose: compact, copy-paste ready spec templates and common matchers for this repo.

1) Request spec template

RSpec.describe "API::V1::Users", type: :request do
  describe 'GET /api/v1/users' do
    it 'returns list of users' do
      create_list(:user, 2)
      get '/api/v1/users'
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['data'].length).to eq(2)
    end
  end
end

1) Model spec template

RSpec.describe User, type: :model do
  it 'validates presence of email' do
    user = build(:user, email: nil)
    expect(user).not_to be_valid
    expect(user.errors[:email]).to include("can't be blank")
  end
end

1) Service spec template

RSpec.describe MyService, type: :unit do
  describe '.call' do
    subject(:result) { described_class.call(params) }

    context 'with valid input' do
      let(:params) { { key: 'value' } }

      it 'returns success' do
        expect(result[:success]).to be true
        expect(result[:response]).to be_present
      end
    end

    context 'with invalid input' do
      let(:params) { {} }

      it 'returns failure with error message' do
        expect(result[:success]).to be false
        expect(result[:response][:error][:message]).to be_present
      end
    end
  end
end

1) Common matchers & helpers

- use `perform_enqueued_jobs` for background jobs
- use `travel_to` for time-dependent tests
- `expect { }.to change { Model.count }.by(1)` for side effects
