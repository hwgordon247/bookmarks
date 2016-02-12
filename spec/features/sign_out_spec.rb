
feature 'sign out' do
  scenario 'there is a sign out option' do
    sign_up_good
    click_button 'Start Bookmarking'
    expect(page).to have_button 'This isn\'t working for me!!!'
  end

  scenario 'the sign out button sends user to a goodbye message' do
    sign_up_good
    click_button 'Start Bookmarking'
    click_button 'This isn\'t working for me!!!'
    expect(page).to have_content 'We are done... don\'t come crying back to me when you loose all your bookmarks'
  end
end
