# == Schema Information
#
# Table name: sessions
#
#  id         :uuid             not null, primary key
#  user_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Session < ApplicationRecord
  belongs_to :user

  def self.destroy_expired
    where('updated_at < ?', 1.hour.ago).destroy_all
  end

  def update_lifetime!
    update_attribute :updated_at, Time.now
  end
end
