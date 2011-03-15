# == Schema Information
# Schema version: 20110308151603
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#  admin              :boolean
#

# == Schema Information
# Schema version: 20110228135040
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#
require 'digest'
class User < ActiveRecord::Base
  attr_accessor :password
	attr_accessible :name, :email, :password, :password_confirmation, :last_login
	
	has_many :questions, :dependent => :destroy
	has_many :answers, :dependent => :destroy
	has_many :favorites, :dependent => :destroy
	has_many :votes, :dependent => :destroy

	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :name, :presence 	=> true,
									 :length		=> { :maximum => 50 }
	validates :email, :presence 	=> true,
									  :format			=> { :with => email_regex },
										:uniqueness	=> { :case_sensitive => false } 
  validates :password,   :presence      => true,
                         :confirmation  => true,
                         :length        => { :within => 6..40 },
                         :if            => :should_validate_password?
                         
 before_save :encrypt_password, :if => :should_validate_password?
 
 default_scope :order => 'users.name ASC'

 def should_validate_password?
   !password.blank? || !password_confirmation.blank? || new_record?
 end

 def has_password?(submitted_password)
   encrypted_password == encrypt(submitted_password)
 end
 
 def self.authenticate(email, submitted_password)
   user = find_by_email(email)
   return nil  if user.nil? or !user.active?
   return user if user.has_password?(submitted_password)
 end

 def self.authenticate_with_salt(id, cookie_salt)
   user = find_by_id(id)
   (user && user.salt == cookie_salt) ? user : nil
 end

	def favorite?(question)
		favorites.find_by_question_id(question)
	end

	def favorite!(question)
		favorites.create!(:question_id => question.id)
	end

	def unfavorite!(question)
		favorites.find_by_question_id(question).destroy
	end

	def answer!(question, content)
		answers.create!(:question_id => question.id, :content => content, :published => true)
	end
	
	def vote!(question, answer, value)
	  votes.create!(:question_id => question.id, 
	                :answer_id => answer.id, 
	                :value => value)
  end

	private

		def encrypt_password
			self.salt = make_salt if new_record?
			self.encrypted_password = encrypt(password)
		end

		def encrypt(string)
			secure_hash("#{salt}--#{string}")
		end

		def make_salt
			secure_hash("#{Time.now.utc}--#{password}")
		end

		def secure_hash(string)
			Digest::SHA2.hexdigest(string)
		end
end
