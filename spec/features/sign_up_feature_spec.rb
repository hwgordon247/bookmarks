require 'spec_helper'
require './app/app.rb'

feature 'Sign Up' do

  scenario 'Signing up a new user' do
    expect {sign_up('KokoKitscha', 'viola.crellin@gmail.com', 'password123')}.to change(User, :count).by(1)
  end

  scenario 'Welcoming a new user' do
    sign_up('KokoKitscha', 'viola.crellin@gmail.com', 'password123')
    expect(page).to have_content('WELCOME TO BOOKMARKER MANAGERESS KokoKitscha!')
  end

  scenario 'Checking a new user\'s email' do
    sign_up('KokoKitscha', 'viola.crellin@gmail.com', 'password123')
    expect(User.first.email).to eq('viola.crellin@gmail.com')
  end
end
