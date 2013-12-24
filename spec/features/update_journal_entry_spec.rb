require 'spec_helper'

feature 'user view existing post' do

  scenario 'user can click on existing journal entry' do
    entry = FactoryGirl.create(:journal_entry)
    visit journal_entries_path
    click_on entry.title
    click_on 'Submit'
    expect(page).to have_content entry.title
  end

  scenario 'user can delete existing journal entry' do
    entry = FactoryGirl.create(:journal_entry)
    visit journal_entries_path
    click_on 'Destroy'
    expect(page).to_not have_content entry.title
  end

  scenario 'user can update current attributes of journal' do
    entry = FactoryGirl.create(:journal_entry)
    categories = FactoryGirl.create_list(:category, 3)
    visit journal_entry_path(entry)
    # expect(page).to have_content entry.title
    expect(page).to have_content entry.description
    category1 = categories.first
    category2 = categories[1]
    category3 = categories.last
    fill_in 'Title', with: 'Obscure Reference'
    fill_in'Description', with: 'Deep and meaningful content'
    expect(page).to have_content category1.name
    expect(page).to have_content category2.name
    expect(page).to have_content category3.name
    click_on 'Submit'
    expect(page).to have_content 'Obscure Reference'
    expect(page).to have_content 'Deep and meaningful content'
  end

end
