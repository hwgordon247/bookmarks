def sign_up
  visit '/users/new'
  expect(page.status_code).to eq 200
  fill_in :email, with: 'bob@gmail.com'
  fill_in :password, with: 'potato'
  fill_in :password_confirmation, with: 'potato'
  click_button "Sign up"
end

def fail_sign_up
  visit '/users/new'
  expect(page.status_code).to eq 200
  fill_in :email, with: 'bob@gmail.com'
  fill_in :password, with: 'potato'
  fill_in :password_confirmation, with: 'apple'
  click_button "Sign up"
end

def no_email_entered
  visit '/users/new'
  expect(page.status_code).to eq 200
  fill_in :email, with: nil
  fill_in :password, with: 'potato'
  fill_in :password_confirmation, with: 'potato'
  click_button "Sign up"
end

def invalid_email_entered
  visit '/users/new'
  expect(page.status_code).to eq 200
  fill_in :email, with: 'bob@hello'
  fill_in :password, with: 'potato'
  fill_in :password_confirmation, with: 'potato'
  click_button "Sign up"
end

def repeat_email
  sign_up
  sign_up
end
