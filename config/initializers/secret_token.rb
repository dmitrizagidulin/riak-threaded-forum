# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
RiakThreadedForum::Application.config.secret_key_base = 'dbecaa6e4cd17b16b1f16b05282e80369f703513c8a433c8a2f59009b262895591a3dfe4906101409d523486c2e3002048b24659cc1c8b185646cfbe9be7d670'
