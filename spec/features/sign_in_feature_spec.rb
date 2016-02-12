
feature 'sign_in' do
  scenario 'there is a sign_in option on the intro page' do
    visit '/'
    expect(page).to have_content 'Sign In'
    expect(page).to have_button 'Sign In'
  end

  scenario 'an existing user can sign in and get a welcome message' do
    sign_in
    expect(page).to have_content('WELCOME TO BOOKMARKER MANAGERESS KokoKitscha!')
  end

  scenario 'will send an error message when username not recognised' do
    sign_in_bad_username
    expect(page).to have_content "Who are you?"
  end

  scenario 'will send an error message when password not recognised' do
    sign_in_bad_password
    expect(page).to have_content "Computer says no"
  end
end
