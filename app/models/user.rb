class User
  attr_reader :user, :email, :password

  @@count = 0

  def self.add(email, password)
    @user = User.new(email, password)
  end

  def self.instance
    @user
  end

  def initialize(email, password)
    @email = email
    @password = password
    self.class.count += 1
  end

  def self.count
    @@count
  end

  def self.count=(value)
    @@count = value
  end
end
