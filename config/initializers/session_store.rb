# Be sure to restart your server when you modify this file.

if Rails.env.production?
  Belloh::Application.config.session_store :cookie_store, key: '_belloh_session', domain: 'belloh.com'
else
	Belloh::Application.config.session_store :cookie_store, key: '_belloh_session', domain: 'lvh.me'
end