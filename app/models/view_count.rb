class ViewCount < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
  def self.increment(user, book)
    unless ViewCount.find_by(user: user, book: book)
      ViewCount.create(user: user, book: book)
    end
  end
  
  def self.count(book)
    ViewCount.where(book: book).count
  end
end
