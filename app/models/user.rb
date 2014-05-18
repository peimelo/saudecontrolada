class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  devise :confirmable,
         :database_authenticatable,
         :lockable,
         # :omniauthable,
         :recoverable,
         :registerable,
         :rememberable,
         :trackable,
         :validatable,
         :timeoutable

  # Setup accessible (or protected) attributes for your model
  #  attr_accessible :email, :name, :password, :password_confirmation, :remember_me

  # relacionamentos -------------------------------------------------------------------------------
  has_many :peso, dependent: :delete_all

  # validações ------------------------------------------------------------------------------------
  validates :date_of_birth, :gender, :name, presence: true
end
