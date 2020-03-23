class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

  attachment :profile_image, destroy: false

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # 'favorites'はモデル名ではなくメソッドとして定義している。
  has_many :book_comments, dependent: :destroy

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50}

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy #フォロー取得
  # 外部キーの定義
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy #フォロワー取得
  # 外部キーの定義
  has_many :following_user, through: :follower, source: :followed #自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower #自分をフォローしている人
  # foregin_key = 入口　source = 出口　through: :○○○ = 中間テーブルは○○○
  # follower_id(自分) → follower_id(自分)を目印にfollower(中間テーブル)に入り,
  # followed_id(自分がフォローしている人＝他人)の情報を取得して出てくる。
  # following_userで取得できるのは自分がフォローしている＝他人のデータ

  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  #フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end



end
