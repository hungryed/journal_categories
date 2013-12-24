class JournalEntry < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :description
  has_many :journal_categories,
    inverse_of: :journal_entry
  has_many :categories,
    through: :journal_categories,
    inverse_of: :journal_entries

  # validate :approve_title
  # validate :approve_description


  # def approve_title
  #   if title.present?
  #     errors.add(:title, 'Please include titleify it')
  #   end
  # end

  # def approve_description
  #   if description.present?
  #     errors.add(:description, 'Open the door')
  #   end
  # end

end
