class User < ActiveRecord::Base
has_many :tweets
has_secure_password

  def slug
    self.name.downcase.gsub(' ','-')
  end

  def self.find_by_slug(slug)
    User.all.find{|x| x.slug == slug}
  end
end
