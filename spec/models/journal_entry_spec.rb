require 'spec_helper'

describe JournalEntry do
  it { should validate_presence_of :title }
  it { should validate_presence_of :description }
  it { should have_many :journal_categories }
  it { should have_many(:categories).through(:journal_categories) }

  it "should not allow blank title" do
    entry = JournalEntry.new
    entry.valid?
    expect(entry.errors[:title]).to include("can't be blank")
  end

  it "should not allow blank description" do
    entry = JournalEntry.new
    entry.valid?
    expect(entry.errors[:description]).to include("can't be blank")
  end
end
