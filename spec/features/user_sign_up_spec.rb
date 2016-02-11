feature 'User sign up' do
  scenario 'a user can sign up' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content "Welcome, bob@gmail.com"
    expect(User.first.email).to eq "bob@gmail.com"
  end

  scenario 'a user cannot sign up with a blank email field' do
    expect { no_email_entered }.not_to change(User, :count)
  end

  scenario 'a user cannot sign up with an invalid email address' do
    expect { invalid_email_entered }.not_to change(User, :count)
  end

  scenario 'user cannot sign up with an already registered email address' do
    expect {repeat_email}.to change(User, :count).by(1)
    expect(page).to have_content "Email is already taken"
  end
end
