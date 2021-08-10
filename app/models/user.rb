class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books,dependent: :destroy

  has_many :favorites,dependent: :destroy
  has_many :favorited_books,through: :favorites,source: :book

  has_many :book_comments,dependent: :destroy

# フォロー取得
  has_many :follower,class_name:"Relationship",foreign_key:"follower_id",dependent: :destroy
# 自分がフォローしている人
  has_many :following_user,through: :follower,source: :followed

# フォロワー取得
  has_many :followed,class_name:"Relationship",foreign_key:"followed_id",dependent: :destroy

# 自分をフォローしている人
  has_many :follower_user,through: :followed,source: :follower

  # ユーザーフォロー
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーフォロー解除
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end


  attachment :profile_image

  validates :name,length:{minimum:2,maximum:20},uniqueness:true
  validates :introduction,length:{maximum:50}

  # 検索機能----------------------------------------------------------

  def self.search(search,word)
    if search == "forward_match"
      @user=User.where("name like?","#{word}%")
    elsif search == "backward_match"
      @user=User.where("name like?","%#{word}")
    elsif search == "perfect_match"
      @user=User.where(name:"#{word}")
    elsif search == "partial_match"
      @user=User.where("name like?","%#{word}%")
    else
      @user=User.all
    end
  end

  # ------------------------------------------------------------------

end
