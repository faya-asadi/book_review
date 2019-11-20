

class EmailformatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end





class User < ApplicationRecord
  has_many :books
  has_many :reviews
  before_save {self.email = email.downcase}
  #username should not be null
  validates :username, presence: true, uniqueness: {case_sensitive: false},
            length: {minimum:4, maximum: 25}

  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,  uniqueness: {case_sensitive: false}, emailformat: true     #format: {with: VALID_EMAIL_REGEX}
  has_secure_password
end
