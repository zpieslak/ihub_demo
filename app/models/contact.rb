# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  phone      :string(255)
#  user_id    :integer
#  group_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Contact < ActiveRecord::Base
  attr_accessible :email, :group_id, :name, :phone

  belongs_to :group
  belongs_to :user

  validates :name, :presence => true, :length => { :within => 2..255 }
  validates :email, :allow_blank => true, :format => { :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :phone, :allow_blank => true, :length => { :within => 2..255 }
end
