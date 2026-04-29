# RSpec Examples

Executable spec patterns for common Rails scenarios.

## Request Spec (endpoint behavior)

```ruby
# spec/requests/orders/create_spec.rb
RSpec.describe 'POST /orders', type: :request do
  let(:product) { create(:product, stock: 5) }

  context 'when product is in stock' do
    it 'creates the order and returns 201' do
      post orders_path, params: { order: { product_id: product.id, quantity: 1 } }, as: :json
      expect(response).to have_http_status(:created)
      expect(response.parsed_body['id']).to be_present
    end
  end

  context 'when product is out of stock' do
    before { product.update!(stock: 0) }

    it 'returns 422 with an error message' do
      post orders_path, params: { order: { product_id: product.id, quantity: 1 } }, as: :json
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body['error']).to eq('Out of stock')
    end
  end
end
```

## Model Spec (domain rule)

```ruby
# spec/models/order_spec.rb
RSpec.describe Order, type: :model do
  describe '#total_price' do
    it 'sums line item prices' do
      order = build(:order, line_items: [
        build(:line_item, price: 10, quantity: 2),
        build(:line_item, price: 5,  quantity: 3)
      ])
      expect(order.total_price).to eq(35)
    end
  end

  describe 'validations' do
    it 'is invalid without a product' do
      order = build(:order, product: nil)
      expect(order).not_to be_valid
      expect(order.errors[:product]).to include("can't be blank")
    end
  end
end
```

## Service Spec (orchestration flow)

```ruby
# spec/services/orders/create_order_spec.rb
RSpec.describe Orders::CreateOrder do
  describe '.call' do
    let(:user)    { create(:user) }
    let(:product) { create(:product, stock: 5) }
    subject(:result) { described_class.call(user: user, product_id: product.id, quantity: 1) }

    it 'returns success with the new order' do
      expect(result[:success]).to be true
      expect(result[:response][:order]).to be_persisted
    end

    context 'when out of stock' do
      before { product.update!(stock: 0) }

      it 'returns failure with an error message' do
        expect(result[:success]).to be false
        expect(result[:response][:error][:message]).to eq('Out of stock')
      end
    end
  end
end
```

## External Service Mocking (class method)

Use `allow(ServiceClass).to receive(:method)` — NOT `instance_double` — when the service calls an external class method. Always include a failure context for the external call.

```ruby
# spec/services/campaigns/delivery_service_spec.rb
RSpec.describe Campaigns::DeliveryService do
  describe '.call' do
    let(:campaign) { create(:campaign) }
    let(:user)     { create(:user) }
    let(:segment)  { create(:user_segment, users: [user]) }

    subject(:result) { described_class.call(campaign_id: campaign.id, segment_id: segment.id) }

    context 'when delivery succeeds' do
      before { allow(SendgridClient).to receive(:deliver).and_return({ success: true }) }

      it 'returns delivered count' do
        expect(result[:success]).to be true
        expect(result[:response][:delivered_count]).to eq(1)
      end
    end

    context 'when SendgridClient returns failure' do
      before { allow(SendgridClient).to receive(:deliver).and_return({ success: false, response: { error: { message: 'SMTP error' } } }) }

      it 'returns failure' do
        expect(result[:success]).to be false
      end
    end

    context 'when campaign is not found' do
      subject(:result) { described_class.call(campaign_id: 999_999, segment_id: segment.id) }

      it 'returns not found error' do
        expect(result[:success]).to be false
      end
    end
  end
end
```

## Time-Dependent Spec (travel_to)

Always use `travel_to` for time-dependent assertions — do not set dates in the past as a shortcut.

```ruby
# spec/models/subscription_spec.rb
RSpec.describe Subscription, type: :model do
  describe '#expired?' do
    # Create with current time — then travel forward to test boundaries
    let(:subscription) { create(:subscription, activated_at: Time.current) }

    context 'before expiration (29 days)' do
      it 'is not expired' do
        travel_to 29.days.from_now do
          expect(subscription).not_to be_expired
        end
      end
    end

    context 'after expiration (31 days)' do
      it 'is expired' do
        travel_to 31.days.from_now do
          expect(subscription).to be_expired
        end
      end
    end
  end
end
```

## Shared Examples

```ruby
# spec/support/shared_examples/successful_response.rb
RSpec.shared_examples 'a successful response' do |status: :ok|
  it "returns #{status}" do
    expect(response).to have_http_status(status)
  end

  it 'returns JSON' do
    expect(response.content_type).to match(%r{application/json})
  end
end

# Usage
RSpec.describe 'GET /products', type: :request do
  before { get products_path, as: :json }

  include_examples 'a successful response', status: :ok
end
```
