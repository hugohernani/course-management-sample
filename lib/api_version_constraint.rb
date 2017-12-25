class ApiVersionConstraint
  def initialize(options)
    options = options.with_indifferent_access
    @version = options[:version]
    @default = options[:default]
  end

  def matches?(request)
    default || request.headers['Accept'].include?("application/vnd.course-management.v#{version}")
  end

  private
  attr_accessor :version, :default
end
