

feature 'can catch a mismatching password' do
  scenario 'when the password is entered incorrectly in the confirmation' do
    expect { fail_sign_up }.not_to change(User, :count)
    expect(page).to have_content "Sign Up Here"
    expect(page).to have_content "Password does not match the confirmation"
  end

end
