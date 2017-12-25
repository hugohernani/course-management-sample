RSpec::Matchers.define :be_collection_jsonapi_match do |model|
  match do |actual|
    parsed_actual = JSON.parse(actual, symbolize_names: true) rescue actual
    actual_data = parsed_actual.dig(:data).try(:first)

    actual_data.dig(:type) == model && actual_data.dig(:attributes).is_a?(Hash) &&
      parsed_actual.dig(:links).is_a?(Hash)
  end
end

RSpec::Matchers.define :be_collection_assoc_jsonapi_match do |model|
  match do |actual|
    parsed_actual = JSON.parse(actual, symbolize_names: true) rescue actual
    actual_data = parsed_actual.dig[:data].try(:first)

    actual_data.dig(:type) == model && actual_data.dig(:attributes).is_a?(Hash) &&
      actual_data.dig(:relationships).is_a?(Hash) && parsed_actual.dig(:links).is_a?(Hash)
  end
end

RSpec::Matchers.define :be_jsonapi_match do |model|
  match do |actual|
    parsed_actual = JSON.parse(actual, symbolize_names: true) rescue actual
    parsed_actual.dig(:data, :type) == model &&
      parsed_actual.dig(:data, :attributes).is_a?(Hash)
  end
end

RSpec::Matchers.define :be_jsonapi_assoc_match do |model|
  match do |actual|
    parsed_actual = JSON.parse(actual, symbolize_names: true) rescue actual
    parsed_actual.dig(:data, :type) == model &&
      parsed_actual.dig(:data, :attributes).is_a?(Hash) &&
      parsed_actual.dig(:data, :relationships).is_a?(Hash)
  end
end
