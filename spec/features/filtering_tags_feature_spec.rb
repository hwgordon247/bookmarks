require 'spec_helper'
require './app/app.rb'


feature 'Filtering and viewing tags' do

  scenario 'filtering links with certain tags' do

    create_links('www.facebook.com', 'Facebook', 'bubbles')
    create_links('www.somewhere.com', 'Somewhere Other Than Here', 'bubbles')
    create_links('www.somewhere_old.com', 'Somewhere in the past', 'history')
    create_links('www.wordpress.com', 'Wordpress', 'blog')
    visit '/tags/bubbles'
    # fill_in "name", with: 'bubbles'
    # click_button("Search By Tag")


    expect(page.status_code).to eq 200
    within 'ul#links' do
      expect(page).to have_content('Facebook')
      expect(page).to have_content('Somewhere Other Than Here')
      expect(page).not_to have_content('Somewhere in the past')
      expect(page).not_to have_content('Wordpress')
    end
  end

end
