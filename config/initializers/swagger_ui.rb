SwaggerUiEngine.configure do |config|
  config.swagger_url = 'api-docs.json'
  config.model_rendering = 'schema'
  config.doc_expansion = 'list'
  config.request_headers = true
  config.json_editor = true
end
