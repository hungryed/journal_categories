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
    first_journal = FactoryGirl.create(:journal_entry,
      created_at: "2013-12-20 16:21:11",
      updated_at: "2013-12-31 19:21:11")
    middle_journal = FactoryGirl.create(:journal_entry,
      created_at: "2013-12-24 16:21:11",
      updated_at: "2013-12-31 16:21:11")
    last_journal = FactoryGirl.create(:journal_entry,
      created_at: "2013-12-29 16:21:11",
      updated_at: "2013-12-30 16:21:11")
    visit journal_entries_path
    last_journal.title.should appear_before(first_journal.title)
    last_journal.title.should appear_before(middle_journal.title)
    middle_journal.title.should appear_before(first_journal.title)
    first_journal.title.should_not appear_before(last_journal.title)
  end
end
