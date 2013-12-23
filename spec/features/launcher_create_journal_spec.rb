require 'spec_helper'

feature 'user creates journal entry' do
  let(:title) { 'Words of some kind' }
  let(:description) { 'Most amazing Description'}
  # let(post) { FactoryGirl.create(title: 'Awesome Title',
  #           description: 'Even better description')}

  scenario 'user sees input confirmation' do
    visit journal_entries_path
    click_on 'New Post'
    fill_in 'Title', with: title
    fill_in 'Description', with: description
    click_on 'Submit'
    expect(page).to have_content 'This post is legit'
  end

  scenario 'user sees new post upon completion' do
    visit new_journal_entry_path
    fill_in 'Title', with: title
    fill_in 'Description', with: description
    click_on 'Submit'
    expect(page).to have_content title
    expect(page).to have_content description
  end
end
