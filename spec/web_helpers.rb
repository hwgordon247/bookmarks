def create_links(url, title, tags)
  visit '/links/new'
  fill_in 'url', with: url
  fill_in 'title', with: title
  fill_in 'tags', with: tags
  click_button('Add')
end

def sign_up_good
  visit '/'
  fill_in 'user_name', with: 'KokoKitscha'
  fill_in 'email', with: 'viola.crellin@gmail.com'
  fill_in 'password', with: 'password123'
  fill_in 'password_confirmation', with: 'password123'
  click_button('Sign Up')
end

def sign_up_bad(password_confirmation)
  visit '/'
  fill_in 'user_name', with: 'KokoKitscha'
  fill_in 'email', with: 'viola.crellin@gmail.com'
  fill_in 'password', with: 'password123'
  fill_in 'password_confirmation', with: password_confirmation
  click_button('Sign Up')
end

def sign_up_two
  within 'div.wrapper' do
    within 'div#notice' do
      fill_in 'password', with: 'password123'
      fill_in 'password_confirmation', with: 'password123'
      within 'label.submitform' do
      click_button('Try Again')
    end
    end
  end
end

def sign_up_bad_email
  visit '/'
  fill_in 'user_name', with: 'KokoKitscha'
  fill_in 'password', with: 'password123'
  fill_in 'password_confirmation', with: 'password123'
  click_button('Sign Up')
end

def sign_in
  sign_up_good
  visit '/'
  fill_in 'existing_user_name', with: 'KokoKitscha'
  fill_in 'existing_password', with: 'password123'
  click_button('Sign In')
end

def sign_in_bad_username
  sign_up_good
  visit '/'
  fill_in 'existing_user_name', with: 'Potato'
  fill_in 'existing_password', with: 'password123'
  click_button('Sign In')
end
