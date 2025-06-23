Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,
           Rails.application.credentials.dig(:twitter, :api_key),
           Rails.application.credentials.dig(:twitter, :api_secret)
end

# GET isteğine izin ver (csrf_protection gem'i için)
OmniAuth.config.allowed_request_methods = [:post, :get]
