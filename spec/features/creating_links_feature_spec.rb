require 'spec_helper'
require './app/app.rb'


feature 'Adding links' do

  scenario 'Adding a link' do

    create_links('www.wordpress.com', 'Wordpress', 'blog')

    expect(current_path).to eq '/links'

    within 'ul#links' do
      expect(page).to have_text('Wordpress')
    end

  end


end
