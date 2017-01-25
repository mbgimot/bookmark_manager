require 'spec_helper'

feature "Filtering tags" do
  scenario "filters website links by tags" do
    visit ('/links/new')
    url = 'google.com'
    title = 'Google'
    tag = 'bubbles'
    fill_in 'url', with: url
    fill_in 'title', with: title
    fill_in 'tags', with: tag
    click_button 'Create Link'
    click_button 'Filter'
    fill_in 'search_tag', with: tag
    click_button 'Search'

    within 'ul#links' do
      link = Link.first
      # a = link.tags.map(&:name)
      # a.slice! 'bubbles'
      expect(link.tags.map(&:name)).to include tag
      # expect(page).not_to include a
    end
  end
end
