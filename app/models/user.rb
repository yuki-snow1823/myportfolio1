class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image
  # 関連づけた。refileの仕様上idという部分を省きました。

  has_many :books, dependent: :destroy
  # Bookモデルは複数形であってる？
  #length: { minimum: 2}
  validates :name, presence: true, length: { in: 2..20 } 
  validates :introduction, length: {maximum: 50}
end
