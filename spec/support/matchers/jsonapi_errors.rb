RSpec::Matchers.define :have_jsonapi_errors_for do |pointer|
  match do |actual|
    parsed_actual = JSON.parse(actual, symbolize_names: true) rescue actual
    errors = parsed_actual[:errors]
    return false if errors.empty?
    errors.any? do |error|
      error.dig(:source, :pointer) == pointer
    end
  end
end
