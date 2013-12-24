require 'spec_helper'

feature 'user creates journal entry' do
  let(:title) { 'Words of some kind' }
  let(:description) { 'Most amazing Description'}

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

  scenario 'user receives error for invalid input' do
    visit new_journal_entry_path
    click_on 'Submit'
    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "Description can't be blank"
  end

  scenario 'user can select a category' do
    category = FactoryGirl.build(:category, name: 'This category')
    visit new_journal_entry_path
    expect(page).to have_content category.name
    Category.destroy_all
  end
end
