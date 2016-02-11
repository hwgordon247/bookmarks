def create_links(url, title, tags)
  visit '/links/new'
  fill_in 'url', with: url
  fill_in 'title', with: title
  fill_in 'tags', with: tags
  click_button('Add')
end

def sign_up(user, email, password)
  visit '/'
  fill_in 'user_name', with: user
  fill_in 'email', with: email
  fill_in 'password', with: password
  click_button('Sign Up')
end
