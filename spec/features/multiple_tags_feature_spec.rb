require 'spec_helper'
require './app/app.rb'

feature 'Adding many tags to one link' do

  scenario 'Adding multiple tags' do
    create_links('www.illogicode.wordpress.com/', 'illogicode', 'blog, learn to code, coding, illogical')
    link = Link.all
    expect(link.tags.map(&:name)).to include('blog', 'illogical', 'learn to code')
  end

end
