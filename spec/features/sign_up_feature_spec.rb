require 'spec_helper'
require './app/app.rb'

feature 'Sign Up' do

  scenario 'Signing up a new user' do
    expect {sign_up_good}.to change(User, :count).by(1)
  end

  scenario 'Checking a new user\'s password matches' do
    expect{sign_up_bad(password_confirmation: 'wrong')}.not_to change(User, :count)
  end

  scenario 'Welcoming a new user' do
    sign_up_good
    expect(page).to have_content('WELCOME TO BOOKMARKER MANAGERESS KokoKitscha!')
  end

  scenario 'Unmatching passwords do not move to welcome page' do
    sign_up_bad(password_confirmation: 'wrong')
    expect(current_path).to eq('/sign_up')
    expect(current_path).not_to eq('/welcome')
  end

  scenario 'Unmatching passwords display a flash message' do
    sign_up_bad(password_confirmation: 'wrong')
    expect(page).to have_content('Ooops, your passwords didn\'t match')
  end

  scenario 'Secondary form displays when attempting another sign up' do
    sign_up_bad(password_confirmation: 'wrong')
    sign_up_two
    expect(page).to have_content("WELCOME TO BOOKMARKER MANAGERESS KokoKitscha! Ready?")
  end

# EMAIL validation
  scenario 'Checking a new user\'s email' do
    sign_up_good
    expect(User.first.email).to eq('viola.crellin@gmail.com')
  end

  scenario 'Checking database does not add a new user if no email supplied' do
    expect{sign_up_bad_email}.not_to change(User, :count)
  end

  scenario 'Checking no duplicate emails in database when signing up' do
    sign_up_good
    sign_up_good
    expect(page).to have_content('Ooops, your email looks a bit fishy')
    expect(page).not_to have_content('Ooops, your passwords didn\'t match')
    expect(current_path).to eq('/sign_up')
    expect(current_path).not_to eq('/welcome')
  end

  scenario 'Checking a duplicated email sign up doesn\'t add to database' do
    expect{2.times{sign_up_good}}.to change(User, :count).by(1)
  end



  scenario 'Let the user start bookmarking' do
    sign_up_good
    click_button('Start Bookmarking')
    expect(page).to have_content('URL Title Tag')
  end

end
