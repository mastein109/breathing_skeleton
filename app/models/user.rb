class User < ActiveRecord::Base
    validate :validate_password

  def password
    @hashed_password_obj ||= BCrypt::Password.new(self.password_hash)
  end

  def password=(plaintext_password)
    @plaintext_password = plaintext_password
    @hashed_password_obj = BCrypt::Password.create(plaintext_password)
    self.password_hash = @hashed_password_obj.to_s
  end

  def validate_password
    if @plaintext_password.nil?
      @errors.add(:password, "is required, mininum 6 characters")
    elsif @plaintext_password.length < 6
      @errors.add(:password, "must be at least 6 characters")
    end
  end

  def self.authenticate(username, plaintext_password)
    if (user = User.find_by(username: username))
      if (user.password == plaintext_password)
        return user
      end
    end
    nil
  end

end
