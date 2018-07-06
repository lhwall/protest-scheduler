class User < ActiveRecord::Base
has_many :events
has_many :categories, through: :events
has_secure_password
end
