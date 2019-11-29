

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

  validates :username, presence: true, uniqueness: {case_sensitive: false},
            length: {minimum:4, maximum: 25}
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: {message: "you should enter a valid email"},  uniqueness: {case_sensitive: false, message: "this email exist in our database"}, emailformat: true     #format: {with: VALID_EMAIL_REGEX}
  has_secure_password

  def new_record?
    id == nil
  end

end
