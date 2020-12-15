class EmailVerification < ApplicationRecord
  before_validation :set_up_email_record
  before_create :set_verification_status
  belongs_to :email_address

  private

  def set_up_email_record
    #lost time, wasn't able to dig into interpreting below fully.
    #Here I would expand this method to add individual email objects to 
    # until we have 10 entries 
    #then iterate through each one to create the structure necessary to post to DB
    #one idea would be to have a hashtable with 10 items and each email entry would 
    #serve as the value for each integer key for the 10 items..
    self.email_address = EmailAddress.find_or_create_by(
      {address: self.address}) do | e |
        e.address = address
    end
  end

  def set_verification_status
    self.verification_status = self.email_address.status
  end

end
