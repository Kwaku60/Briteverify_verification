
require 'fileutils'
include FileUtils

class MainController < ApplicationController

  #here I think there should be a method running that will check the status of current user
  #if inactive, return, otherwise continue 
  puts "====check scope, params==="
  def home
    if !params[:address].blank? 
      #thrown a little by ruby syntax here, but if this were JS or python
      # I would set condition to if param blank, and if status is valid
      #then create the new email address instance to post to DB...
      EmailAddress.new(address: params[:address].to_s).check_status?
      if flash.now[:success] = valid ? "Email is valid!" : "Email is not valid!"
      end  
    end
  end
end

