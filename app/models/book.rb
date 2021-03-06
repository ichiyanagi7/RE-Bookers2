class Book < ApplicationRecord

  belongs_to :user
  has_many :favorites,dependent: :destroy
  has_many :favorited_users,through: :favorites,source: :user
  
  has_many :book_comments,dependent: :destroy

  validates :title,presence:true
  validates :body, presence:true, length:{maximum:200}

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

# 検索機能----------------------------------------------------
  def self.search(search,word)
    @word="#{word}"
    if search == "forward_match"
      @book=Book.where("title like?","#{word}%")
    elsif search == "backward_match"
      @book=Book.where("title like?","%#{word}")
    elsif search == "perfect_match"
      @book=Book.where(title:"#{word}")
    elsif search == "partial_match"
      @book=Book.where("title like?","%#{word}%")
    else
      @book=Book.all
    end
  end

end
