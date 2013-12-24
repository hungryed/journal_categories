class JournalCategory < ActiveRecord::Base
  belongs_to :journal_entry
  belongs_to :category

  validates_presence_of :category
  validates_presence_of :journal_entry
  validates_uniqueness_of :journal_entry_id,
    scope: :category_id
end
