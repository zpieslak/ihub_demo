# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Group < ActiveRecord::Base
  attr_accessible :name

  belongs_to :user
  has_many :contacts

  validates :name, :presence => true, :length => { :within => 2..255 }
end
