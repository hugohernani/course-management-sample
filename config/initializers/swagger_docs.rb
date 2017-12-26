class Swagger::Docs::Config
  def self.transform_path(path, api_version)
    "documentation/single_swagger_doc/#{path}"
  end
end

Swagger::Docs::Config.base_api_controller = ActionController::API

Swagger::Docs::Config.register_apis({
  "1.0" => {
    api_file_path: "public/documentation/single_swagger_doc",
    base_path: "http://api.fractal-technology.dev:3000",
    clean_directory: true,
    attributes: {
      info: {
        "title" => "Course management API",
        "description" => "Course management",
        "contact" => "hhernanni@gmail.com",
        "license" => "Apache 2.0",
        "licenseUrl" => "http://www.apache.org/licenses/LICENSE-2.0.html"
      }
    }
  }
})
