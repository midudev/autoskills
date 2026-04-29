# RSpec Service Testing — Patterns

## FactoryBot Hash Factory for API Responses

Use `class: Hash` with `initialize_with` to build hash-shaped API response fixtures:

```ruby
FactoryBot.define do
  factory :api_entity_response, class: Hash do
    transient do
      field1 { FFaker::Name.first_name }
      field2 { FFaker::Random.rand(1..1000) }
    end

    initialize_with do
      columns = ModuleName::Entity::ATTRIBUTES.map { |attr| { 'name' => attr, 'type_text' => 'STRING' } }
      { 'manifest' => { 'schema' => { 'columns' => columns } }, 'result' => { 'data_array' => [[field1, field2]] } }
    end
  end
end
```

Place the factory at `spec/factories/module_name/entity_response_factory.rb`.

Use in specs:

```ruby
let(:api_response) { build(:api_entity_response, field1: 'Alice', field2: 42) }
```
