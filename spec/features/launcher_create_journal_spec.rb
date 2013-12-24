require 'spec_helper'

feature 'user creates journal entry' do
  let(:title) { 'Words of some kind' }
  let(:description) { 'Most amazing Description'}
  after(:all) { Category.destroy_all}
  after(:all) { JournalEntry.destroy_all}

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

  scenario 'user sees creation date upon entry' do
    entry = FactoryGirl.create(:journal_entry)
    visit journal_entries_path
    expect(page).to have_content entry.created_at
    entry.destroy
  end

  scenario 'user receives error for invalid input' do
    visit new_journal_entry_path
    click_on 'Submit'
    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "Description can't be blank"
  end

  scenario 'user can select a category' do
    category = FactoryGirl.create(:category, name: 'This category')
    visit new_journal_entry_path
    expect(page).to have_content category.name
  end

  scenario 'entries are ordered by date created_at' do
    entries = FactoryGirl.create_list(:journal_entry, 5)
    counter = 100
    entries.each do |entry|
      entry.created_at -= counter
      entry.updated_at -= counter - 30
      counter += 100
      entry.save
    end
    binding.pry
  end
end
