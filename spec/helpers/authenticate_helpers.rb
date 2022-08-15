
def create_auth_header_from_scratch
  # You need to set up factory bot to use this method
  @current_user = FactoryBot.create(:user)

  # create token
  token = DeviseTokenAuth::TokenFactory.create

  # store client + token in user's token hash
  @current_user.tokens[token.client] = {
    token:  token.token_hash,
    expiry: token.expiry
  }

  # Now we have to pretend like an API user has already logged in.
  # (When the user actually logs in, the server will send the user
  # - assuming that the user has  correctly and successfully logged in
  # - four auth headers. We are to then use these headers to access
  # things which are typically restricted
  # The following assumes that the user has received those headers
  # and that they are then using those headers to make a request

  new_auth_header = @current_user.build_auth_header(token.token, token.client)
end