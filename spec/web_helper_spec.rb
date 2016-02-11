def sign_up
  visit '/users/new'
  expect(page.status_code).to eq 200
  fill_in :email, with: 'bob@gmail.com'
  fill_in :password, with: 'potato'
  click_button "Sign up"
end
