class User < ActiveRecord::Base
  validates_presence_of :email, :password
  validates_uniqueness_of :email


  def login_attempt_counter
    #everytime there is a bad login attempt update the counter in the sessions database
    self.logins += 1
    p "Number of login attempts"
    p self.logins
    p "*"*80
    self.save
  end

  def check_user_logins
    #when there is a bad attempt, check the db to see if they have reached the maximum
    if self.logins >= 4
      self.wait_1_minute
    else
      self.login_attempt_counter
    end
  end

  def erase_logins
    self.update(logins: 0)
  end

  def wait_1_minute
    if (DateTime.now.to_i - self.updated_at.to_i) < 60
      # if the current time is less than 1 minute since the last bad attempt, update the counter again
      p "Seconds since last login attempt"
      p DateTime.now.to_i - self.updated_at.to_i
      self.login_attempt_counter
    else
      p "YOU HAVE WAITED ENOUGH TIME, LOGIN COUNTER RESET"
      erase_logins
      login_attempt_counter
    end
  end



end
