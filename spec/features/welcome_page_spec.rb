feature 'welcome page' do
  scenario 'has a link to the sign up page' do
    click_button "Sign up"
    expect(page).to have_button "Sign up here"
  end
end
