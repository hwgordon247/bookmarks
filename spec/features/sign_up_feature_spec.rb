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

  scenario 'Checking a new user\'s email' do
    sign_up_good
    expect(User.first.email).to eq('viola.crellin@gmail.com')
  end



  scenario 'Let the user start bookmarking' do
    sign_up_good
    click_button('Start Bookmarking')
    expect(page).to have_content('URL Title Tag')
  end

end
