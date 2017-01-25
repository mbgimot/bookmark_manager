require 'spec_helper'

feature "Adding tags" do
  scenario "adds a tag to a website link" do
    visit ('/links/new')
    url = rand(1000)
    title = rand(1000)
    tag = 'education'
    fill_in 'url', with: url
    fill_in 'title', with: title
    fill_in 'tags', with: tag
    click_button 'Create Link'

    within 'ul#links' do
      link = Link.first
      expect(link.tags.map(&:name)).to include('education')
    end
  end
end
