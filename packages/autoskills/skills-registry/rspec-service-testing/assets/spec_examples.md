# RSpec Service Testing Examples

Service object testing patterns for rspec-service-testing skill.

1) Unit test for service object

# frozen_string_literal: true
RSpec.describe Users::SyncService, type: :unit do
  describe '.call' do
    it 'returns success and creates records' do
      user = build(:user)
      result = Users::SyncService.call(user: user)
      expect(result[:success]).to be true
      expect(result[:response]).to include(:synced_count)
    end
  end
end

2) Error handling spec

RSpec.describe Users::SyncService, type: :unit do
  it 'returns error shape when external API fails' do
    allow(ExternalApi).to receive(:push).and_raise(Net::OpenTimeout)
    result = Users::SyncService.call(user: create(:user))
    expect(result[:success]).to be false
    expect(result[:response][:error]).to match(/timeout/i)
  end
end

3) Integration-style spec using perform_enqueued_jobs for background jobs

RSpec.describe 'Sync integration', type: :integration do
  it 'enqueues and performs SyncUserJob' do
    user = create(:user)
    expect { SyncUserJob.perform_later(user.id) }.to have_enqueued_job(SyncUserJob)
    perform_enqueued_jobs
    # assert side effects
  end
end
