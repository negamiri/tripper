class Invite < ApplicationRecord
  belongs_to :trip

  before_create :generate_token
  before_save :check_user_existence

  def generate_token
    self.token = Digest::SHA1.hexdigest([self.trip_id, Time.now, rand].join)
  end

  def check_user_existence
    recipient = User.find_by_email(email)
    if recipient
      self.recipient = recipient.id
    end 
  end

end
