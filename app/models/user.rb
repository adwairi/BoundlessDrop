class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include ActiveModel::Validations
  # validates_with EmailValidator
  #
  # validates :first_name, presence: true, length: { minimum: 3 }
  # validates :last_name, presence: true, length: { minimum: 3 }
  # validates :username, presence: true, length: { minimum: 5 }, uniqueness: {scope: :username, message: "username is already taken"}

end
