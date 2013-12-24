class JournalEntriesController < ApplicationController
  def index
    @journal_entries = JournalEntry.all.created_order
  end

  def new
    @journal_entry = JournalEntry.new
    @categories = Category.all
  end

  def show
    @journal_entry = JournalEntry.find(params[:id])
    @categories = Category.all
  end

  def create
    @journal_entry = JournalEntry.new(journal_params)
    if @journal_entry.save
      redirect_to journal_entries_path, notice: 'This post is legit'
    else
      render :new
    end
  end

  def update
    @journal_entry = JournalEntry.find(params[:id])

    if @journal_entry.update_attributes(journal_params)
      redirect_to journal_entries_path
    end
  end

  def destroy
    @journal_entry = JournalEntry.find(params[:id])
    @journal_entry.destroy
    redirect_to journal_entries_path, notice: 'Fuck you journal entry'
  end

  private
  def journal_params
    params.require(:journal_entry).permit(:title, :description, category_ids: [])
  end
end
